//
//  UserModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

struct UserModel: Decodable {
    
    var email: String?
    var userName: String?
    
    var status: String?
}


/*
 {
   "status": "success",
   "data": {
     "accessToken": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InBldGVyIiwibmFtZSI6IlBldGVyIiwidXNlcnBpYyI6Imh0dHBzOi8vczMudXMtd2VzdC0yLmFtYXpvbmF3cy5jb20vb3V0ZXJib3VuZC5kZXYvdXNlcnBpY3MvUTl5UmVCYjItOTJmODVhMzIuanBlZyIsImRvYiI6IjE5ODQtMDktMDFUMDA6MDA6MDAuMDAwWiIsImFjdGl2aXRpZXMiOls3Niw3Nyw3OCw2OV0sInN1YiI6IlE5eVJlQmIyIiwiaWF0IjoxNjU1MTk2NDI5LCJleHAiOjE2NTUyODI4MjksImlzcyI6Im91dGVyYm91bmQuZGV2In0.0pPMVfJcIK41u0VZJo8KYCnphx2i4jtEnC3EqBLRgBRcJ16r1kJte_HcNCH06QY5y0PbNuwriqQHW3zCtYijUg",
     "refreshToken": "2a2c12b060ff2ba0cf2e241b3ea21036"
   }
 }
 */
