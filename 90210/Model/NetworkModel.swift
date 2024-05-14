
enum RoverType: String, CaseIterable {
    case curiosity, opportunity, spirit
}

enum Abbreviation: String, CaseIterable {
     case All
    case FHAZ
    case RHAZ
    case MAST
    case CHEMCAM
    case MAHLI
    case MARDI
    case NAVCAM
    case PANCAM
    case MINITES
    
    var abbreviationTitle: String {
        switch self {
        case .FHAZ:
            return "Front Hazard Avoidance Camera"
        case .RHAZ:
            return "Rear Hazard Avoidance Camera"
        case .MAST:
            return "Mast Camera"
        case .CHEMCAM:
            return "Chemistry and Camera Complex"
        case .MAHLI:
            return "Mars Hand Lens Imager"
        case .MARDI:
            return "Mars Descent Imager"
        case .NAVCAM:
            return "Navigation Camera"
        case .PANCAM:
            return "Panoramic Camera"
        case .MINITES:
            return "Miniature Thermal Emission Spectrometer (Mini-TES)"
        case .All:
            return "All"
        }
    }
}
