
import Foundation

public func readFile<T: Decodable>(
    bundle: Bundle,
    type: T.Type,
    file: String,
    fileType: FileType = .json
) -> Result<T, FileReaderError> {
    guard let path = bundle.path(forResource: file, ofType: fileType.rawValue) else {
        print("FileReaderError: ==> invalid path for \(bundle)")
        return .failure(.invalidPath)
    }
    let url = URL(fileURLWithPath: path)
    var data: Data?
    do {
        data = try Data(contentsOf: url)
    } catch {
        print("FileReaderError: ==> invalid data with error: \(error)")
        return .failure(.invalidData)
    }
    let jsonDecoder = JSONDecoder()
    do {
        let model = try jsonDecoder.decode(T.self, from: data!)
        return .success(model)
    } catch {
        print("FileReaderError: ==> parse error with error: \(error)")
        return .failure(.parseError)
    }
}
