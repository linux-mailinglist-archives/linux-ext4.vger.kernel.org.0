Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75C043346D
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 13:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJSLL4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbhJSLL4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 07:11:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF563C061746
        for <linux-ext4@vger.kernel.org>; Tue, 19 Oct 2021 04:09:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m14so17284271pfc.9
        for <linux-ext4@vger.kernel.org>; Tue, 19 Oct 2021 04:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sLvuXUIVq1jKnhOw/i/BcOZ+oL9amgYiHpm3EvpEBDk=;
        b=KNVqWymYbP/YgK7WJRGKJMnRa5bMTJmCwL3DbBQS8JPWzBuSgM3FSaDEwCL3zUs42P
         qUDox6nTqYpl+4HsHp+qem7olc5vkmeM/BUctxNtq2AF3fkp4MN8I1vquS6qHcyMBWFV
         KR2pZ4H52lEjLYF/Ved5T34PcnDvb2c0sTH/P6kG9K2SnTiIEA0n9qaxUsdn8byIOkP9
         0vm11pc7witUV5zpMRQJe17j0ew381sgQ9Fx/7LoxwNbvc+K0YF1eJCwhgRe9TPISyZa
         0e2YuJPtYqbrzQ0/W+319mf7uJw9+6xURto8aAw5U07CxWgAaYXXVn+tbbiFLMmScrXU
         cR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sLvuXUIVq1jKnhOw/i/BcOZ+oL9amgYiHpm3EvpEBDk=;
        b=M5s7PLPzssZITs/dyP0VzcMfZs6sVlwAFhr8KCx0HxoyWFt80C3/MrKh0KM3DPBd0d
         +TSDoOb7Zjmlz0Xq4Umi2FGgeJ9CTjalw7aGZGkbdLM2dofrp+aoxjrGp0ktLLQsTclX
         W+qd57GLWABrRZfnXXqegWsuopZ2JtUD7ZSR05MGj6sU7VjBQZvChihr5DJePMdtfYUK
         M0os5SvqnmikDvfadzuaG5jw1gytljKf4+vbrIl1rcl4mkprRMY7LaO5iDUGbo5s1MCT
         3NI8O0vD40/SC9ajFkkePYs3vxFWjvwBE/9kgxUWpXzeulWkhgV10XOdsPzR3B43/Hpk
         K3EA==
X-Gm-Message-State: AOAM533FEDnR4EaldfVhbk+/CmR3sN6M2qVPYde7COp0XstfDOctKvVd
        FQIdCYiWk8610S5XRX9IhcpucJHhu2wnobEOzF4=
X-Google-Smtp-Source: ABdhPJxldu5bde29uR7oKFw8e1mIeFblKradyDshqOsFRJgqIyTPqOEfm552T0fkltaNvUJPfHd6xmWT/sVppN3hDBo=
X-Received: by 2002:a05:6a00:2b1:b0:44d:b18:8192 with SMTP id
 q17-20020a056a0002b100b0044d0b188192mr34606546pfs.35.1634641782991; Tue, 19
 Oct 2021 04:09:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:1c05:0:0:0:0 with HTTP; Tue, 19 Oct 2021 04:09:42
 -0700 (PDT)
Reply-To: mr.luisfernando5050@gmail.com
From:   "Mr. Luis Fernando " <mr.alinmusah03@gmail.com>
Date:   Tue, 19 Oct 2021 04:09:42 -0700
Message-ID: <CAK9pk2Ge5VYDxAsV13PDT9XNKA+D0Zddy1VCCSGhz2VvD-f4ow@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

LS0gDQpEZWFyIEZyaWVuZCwNCg0KR3JlZXRpbmdzLg0KDQpIb3cgYXJlIHlvdSBkb2luZyB0b2Rh
eSBpIGhvcGUgZmluZT8NCg0KSSBjYW1lIGFjcm9zcyB5b3VyIGUtbWFpbCBjb250YWN0IHByaW9y
IGEgcHJpdmF0ZSBzZWFyY2ggd2hpbGUgaW4gbmVlZA0Kb2YgeW91ciBhc3Npc3RhbmNlLiBNeSBu
YW1lIE1yLkthc2ltIE1vaGFtZWQg4oCZIEkgd29yayB3aXRoIHRoZQ0KZGVwYXJ0bWVudCBvZiBB
dWRpdCBhbmQgYWNjb3VudGluZyBtYW5hZ2VyIGhlcmUgaW4gVUJBIEJhbmsgb2YgQWZyaWNhLA0K
VGhlcmUgaXMgdGhpcyBmdW5kIHRoYXQgd2FzIGtlZXAgaW4gbXkgY3VzdG9keSB5ZWFycyBhZ28g
YW5kIEkgbmVlZA0KeW91ciBhc3Npc3RhbmNlIGZvciB0aGUgdHJhbnNmZXJyaW5nIG9mIHRoaXMg
ZnVuZCB0byB5b3VyIGJhbmsgYWNjb3VudA0KZm9yIGJvdGggb2YgdXMgYmVuZWZpdCBmb3IgbGlm
ZSB0aW1lIGludmVzdG1lbnQgYW5kIHRoZSBhbW91bnQgaXMgKFVTDQokMjcsNTAwLiBNaWxsaW9u
IERvbGxhcnMpLg0KDQpJIGhhdmUgZXZlcnkgaW5xdWlyeSBkZXRhaWxzIHRvIG1ha2UgdGhlIGJh
bmsgYmVsaWV2ZSB5b3UgYW5kIHJlbGVhc2UNCnRoZSBmdW5kIHRvIHlvdXIgYmFuayBhY2NvdW50
IGluIHdpdGhpbiA3IGJhbmtpbmcgd29ya2luZyBkYXlzIHdpdGgNCnlvdXIgZnVsbCBjby1vcGVy
YXRpb24gd2l0aCBtZSBhZnRlciBzdWNjZXNzIE5vdGUgNTAlIGZvciB5b3Ugd2hpbGUNCjUwJSBm
b3IgbWUgYWZ0ZXIgc3VjY2VzcyBvZiB0aGUgdHJhbnNmZXIgb2YgdGhlIGZ1bmRzIHRvIHlvdXIg
YmFuaw0KYWNjb3VudCBva2F5Lg0KDQpXQUlUSU5HIFRPIEhFQVIgRlJPTSBZT1UuDQpUSEFOS1Mu
DQoNCk1yLmx1aXMgZmVybmFuZG8NCg0KDQoNCg0KDQoNCg0KDQoNCg0K2LXYr9mK2YLZiiDYp9mE
2LnYstmK2LLYjA0KDQrYqtit2YrYp9iqLg0KDQrZg9mK2YEg2K3Yp9mE2YMg2KfZhNmK2YjZhSDY
o9iq2YXZhtmJINij2YYg2KrZg9mI2YYg2KjYrtmK2LHYnw0KDQrZhNmC2K8g2LXYp9iv2YHYqiDY
rNmH2Kkg2KfYqti12KfZhCDYp9mE2KjYsdmK2K8g2KfZhNil2YTZg9iq2LHZiNmG2Yog2KfZhNiu
2KfYtdipINio2YMg2YLYqNmEINil2KzYsdin2KEg2KjYrdirINiu2KfYtSDYo9ir2YbYp9ihINin
2YTYrdin2KzYqQ0K2YXZhiDZhdiz2KfYudiv2KrZgy4g2KfYs9mF2Yog2KfZhNiz2YrYryDZgtin
2LPZhSDZhdit2YXYryDYo9i52YXZhCDZhdi5DQrZhdiv2YrYsSDZgtiz2YUg2KfZhNiq2K/ZgtmK
2YIg2YjYp9mE2YXYrdin2LPYqNipINmH2YbYpyDZgdmKIFVCQSBCYW5rIG9mIEFmcmljYSDYjA0K
2YfZhtin2YMg2YfYsNinINin2YTYtdmG2K/ZiNmCINin2YTYsNmKINin2K3YqtmB2Lgg2KjZhyDZ
gdmKINi52YfYr9mKINmF2YbYsCDYs9mG2YjYp9iqINmI2KPZhtinINio2K3Yp9is2Kkg2KXZhNmK
2YcNCtmF2LPYp9i52K/YqtmDINmB2Yog2KrYrdmI2YrZhCDZh9iw2Kcg2KfZhNmF2KjZhNi6INil
2YTZiSDYrdiz2KfYqNmDINin2YTZhdi12LHZgdmKDQrZhNmD2YTYpyDZhdmG2Kcg2KfZhNin2LPY
qtmB2KfYr9ipINmF2YYg2KfZhNin2LPYqtir2YXYp9ixINmF2K/ZiSDYp9mE2K3Zitin2Kkg2YjY
p9mE2YXYqNmE2LogKNin2YTZiNmE2KfZitin2Kog2KfZhNmF2KrYrdiv2KkNCjI3NTAwINiv2YjZ
hNin2LEuINmF2YTZitmI2YYg2K/ZiNmE2KfYsSkuDQoNCtmE2K/ZiiDZg9mEINiq2YHYp9i12YrZ
hCDYp9mE2KfYs9iq2YHYs9in2LEg2YTYrNi52YQg2KfZhNio2YbZgyDZiti12K/ZgtmDINmI2YrY
t9mE2YIg2LPYsdin2K3Zgw0K2KrYrdmI2YrZhCDYp9mE2KPZhdmI2KfZhCDYpdmE2Ykg2K3Ys9in
2KjZgyDYp9mE2YXYtdix2YHZiiDZgdmKINi62LbZiNmGIDcg2KPZitin2YUg2LnZhdmEINmF2LXY
sdmB2YrYqSDZhdi5DQrYqti52KfZiNmG2YMg2KfZhNmD2KfZhdmEINmF2LnZiiDYqNi52K8g2KfZ
hNmG2KzYp9itINmE2KfYrdi4IDUw2aog2YXZhiDYo9is2YTZgyDYo9ir2YbYp9ihDQo1MNmqINio
2KfZhNmG2LPYqNipINmE2Yog2KjYudivINmG2KzYp9itINiq2K3ZiNmK2YQg2KfZhNij2YXZiNin
2YQg2KXZhNmJINin2YTYqNmG2YMg2KfZhNiw2Yog2KrYqti52KfZhdmEINmF2LnZhw0K2KfZhNit
2LPYp9ioINio2K7ZitixLg0KDQrZgdmKINin2YbYqti42KfYsSDYo9mGINmG2LPZhdi5INmF2YbZ
gy4NCti02YPYsdinLg0KDQrYp9mE2LPZitivINmE2YjZitizINmB2LHZhtin2YbYr9mIDQo=
