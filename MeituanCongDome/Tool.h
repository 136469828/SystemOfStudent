//
//  Tool.h
//  MeituanCongDome
//
//  Created by JCong on 15/10/21.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#ifndef Tool_h
#define Tool_h

#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeigth ([UIScreen mainScreen].bounds.size.heigth)
#define URL_SHOP @"http://api.meituan.com/group/v1/re/p?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=y3Z0JZ9uBcMJpIr8vifmTZfUfis%3D&__skno=84E8FEC2-25F0-47E1-80CE-411C57107FD1&__skts=1455612598.652285&__skua=c2e04036699db0c2fee7c88ca97a211f&__vhost=api.mobile.meituan.com&ci=280&cityId=280&client=iphone&movieBundleVersion=100&msid=7BDF7ECC-3A16-48AD-8489-D1FE850AC5202016-02-16-16-43690&position=23.056822%2C112.444426&timestamp=0&userid=128144498&utm_campaign=AgroupBgroupD200Ghomepage&utm_content=ED10775C24977D0EFC29FB15DE05ECF1F7E788E02AB06B333CF76D6222C71259&utm_medium=iphone&utm_source=AppStore&utm_term=6.2&uuid=ED10775C24977D0EFC29FB15DE05ECF1F7E788E02AB06B333CF76D6222C71259&version_name=6.2"

#define SELL_URL @"http://api.meituan.com/group/v1/deal/activity/30?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=do7%2BCU9lVD8Rep6qXICZYBKCrTw%3D&__skno=32648EB0-D4CD-4A4A-8154-3518EDEA1CBB&__skts=1444294711.012966&__skua=cdc4fb3cc8e6dc9eb3e5acc4e9c7e181&__vhost=api.mobile.meituan.com&ci=30&client=iphone&latlng=22.576768%2C113.863605&movieBundleVersion=100&msid=57F1FFF3-DBD2-4719-BA74-75DA9BA038AD2015-10-08-16-49450&ptId=iphone_6.0.1&userid=161909598&utm_campaign=AgroupBgroupD100&utm_content=CCCECA23405301700F759EDD314402121520F2E33662300E4A4765A3F62064DB&utm_medium=iphone&utm_source=AppStore&utm_term=6.0.1&uuid=CCCECA23405301700F759EDD314402121520F2E33662300E4A4765A3F62064DB&version_name=6.0.1"
#define ADV_URL @"http://api.meituan.com/group/v1/deal/topic/elaborate/city/30?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=ulb5CEk2bkgd8YUPJ6cTHHlHYXc%3D&__skno=0EAC3364-934C-4AA5-8210-A24794C49563&__skts=1444294711.283353&__skua=cdc4fb3cc8e6dc9eb3e5acc4e9c7e181&__vhost=api.mobile.meituan.com&ci=30&client=iphone&latlng=22.576768%2C113.863605&movieBundleVersion=100&msid=57F1FFF3-DBD2-4719-BA74-75DA9BA038AD2015-10-08-16-49450&userid=161909598&utm_campaign=AgroupBgroupD100&utm_content=CCCECA23405301700F759EDD314402121520F2E33662300E4A4765A3F62064DB&utm_medium=iphone&utm_source=AppStore&utm_term=6.0.1&uuid=CCCECA23405301700F759EDD314402121520F2E33662300E4A4765A3F62064DB&version_name=6.0.1"
#define ONEEDPH_URL @"http://api.meituan.com/group/v1/deal/topic/discount/city/30?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=EmI2luwlxPu5ZDfwvp%2BbM5yWjyA%3D&__skno=DE2A44F6-3D2B-4EE9-8B25-EAD6AD631892&__skts=1445580862.821769&__skua=5dfd2c4ce56495c22e07258185fdca62&__vhost=api.mobile.meituan.com&ci=30&client=iphone&latlng=22.576751%2C113.863405&movieBundleVersion=100&msid=7BDF7ECC-3A16-48AD-8489-D1FE850AC5202015-10-23-13-40264&utm_campaign=AgroupBgroup&utm_content=ED10775C24977D0EFC29FB15DE05ECF1F7E788E02AB06B333CF76D6222C71259&utm_medium=iphone&utm_source=AppStore&utm_term=6.0.1&uuid=ED10775C24977D0EFC29FB15DE05ECF1F7E788E02AB06B333CF76D6222C71259&version_name=6.0.1"

#define SEVER_URL @"http://api.meituan.com/group/v1/deal/topic/beautiful/city/30?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=pfUy0ClqJxEr%2FwPSwRPqNqKjZwU%3D&__skno=93552411-08C1-4473-9872-0768100E894D&__skts=1444294711.351202&__skua=cdc4fb3cc8e6dc9eb3e5acc4e9c7e181&__vhost=api.mobile.meituan.com&ci=30&client=iphone&latlng=22.576768%2C113.863605&movieBundleVersion=100&msid=57F1FFF3-DBD2-4719-BA74-75DA9BA038AD2015-10-08-16-49450&userid=161909598&utm_campaign=AgroupBgroupD100&utm_content=CCCECA23405301700F759EDD314402121520F2E33662300E4A4765A3F62064DB&utm_medium=iphone&utm_source=AppStore&utm_term=6.0.1&uuid=CCCECA23405301700F759EDD314402121520F2E33662300E4A4765A3F62064DB&version_name=6.0.1"

#define URL_City @"http://api.meituan.com/group/v1/city/latlng/22.579807,113.858488?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=eFNwYtRHLkclXRIeMydMp%2F8dskM%3D&__skno=B5C24D03-9B0C-422E-ACAD-DEB126CA49B3&__skts=1446034655.546679&__skua=5dfd2c4ce56495c22e07258185fdca62&__vhost=api.mobile.meituan.com&ci=30&client=iphone&movieBundleVersion=100&msid=7BDF7ECC-3A16-48AD-8489-D1FE850AC5202015-10-28-20-01591&tag=1&userid=128144498&utm_campaign=AgroupBgroupD200Ghomepage&utm_content=ED10775C24977D0EFC29FB15DE05ECF1F7E788E02AB06B333CF76D6222C71259&utm_medium=iphone&utm_source=AppStore&utm_term=6.0.1&uuid=ED10775C24977D0EFC29FB15DE05ECF1F7E788E02AB06B333CF76D6222C71259&version_name=6.0.1"
#endif /* Tool_h */
