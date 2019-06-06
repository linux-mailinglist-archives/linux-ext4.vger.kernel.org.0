Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63203742B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2019 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfFFMcu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jun 2019 08:32:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfFFMcu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jun 2019 08:32:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id v29so1854824ljv.0
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jun 2019 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vaVAGfvIWmlk7NtGq1TPLC8ZKE6xRNld3Q7CKBoUXaw=;
        b=Dbiovk8ouunaJQRHMVqIJGlVObWaS7VVzG3itjvdtaBAlisSGpHCrhTW1XLyJCJxpP
         FNUpZoLUKiDRWNKBgTVeP3xhB4UZMqoefcdWr3LbfcZFRz/IjqOzyaesMDl3iW9lwUNO
         7SrwhBArqdooHDmUBtbcLr4E5XIbMJuNEQD2QSPPVc1v3Ku0MqRo3esEblFfW9X985mK
         17L3TuBctpvtQamvQpQkYcaGjWg+K5tmsQ86urGgDghsglYJu/yppXA/OtnGxW30yTIg
         rVWHIywZb2yJpWXSS1fhuarNEmKCWd1t6fJUGw95Us7HocoThFfxJCk3Y1W4XNVtTrLh
         YOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vaVAGfvIWmlk7NtGq1TPLC8ZKE6xRNld3Q7CKBoUXaw=;
        b=iHlluuMa0Qj/RVurKY0/wPKu6VwR3IvAsqfLMpA/kFCoC7OFs2fbYRRCU7IlzPE4H7
         RBLGPcLBll1/sjbMA5Ix5kB8m2MQBdEqHbpinCK0vt6Eqc7xQQ1rxiJ6HcnxeOZ95Kti
         bnTT8UnYFrqfzyO+TeaQxMaYB+Dlezprz/fZnWMGCSYYvitdJD37UlBrzQfL7NcEI1vM
         z4Yaboyl5oJSbUVdUFl6nMtRS5YcMnvaL0ba/TblpoPp52boNT0b+z4DJuBv7zIVSTu6
         C98fUAeUEh1Qua57d23kglgQ18Q3hBBrMh+Tp1p7aaGzT7NS5rs2E3zAoJ8i7enOZG45
         gu4Q==
X-Gm-Message-State: APjAAAWhimkCu9CXURXlLJSjn9GVoL8uxW2d8lSKLSsY5SjVXhRcEYwS
        ct2hK+NKrwzn3JM3VlzIlDF7kb/oa+c=
X-Google-Smtp-Source: APXvYqwr/K+19LwU85dY7t5VMD74g6wqOViy63CATpp0NDfgRxx+R2Cbr3joSqFaXY7S+zwHhgLATQ==
X-Received: by 2002:a2e:8591:: with SMTP id b17mr13682386lji.71.1559824368608;
        Thu, 06 Jun 2019 05:32:48 -0700 (PDT)
Received: from [192.168.1.192] ([195.208.173.203])
        by smtp.gmail.com with ESMTPSA id b18sm276929lfi.30.2019.06.06.05.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:32:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [HELP] What are the allocated blocks on a newly created ext4 fs ?
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
In-Reply-To: <b64110a4-8112-a230-2179-5095aa943af9@gmail.com>
Date:   Thu, 6 Jun 2019 15:32:44 +0300
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FD3148B-1E27-4BFA-965C-9FDC7FC8FD96@gmail.com>
References: <b64110a4-8112-a230-2179-5095aa943af9@gmail.com>
To:     Jianchao Wang <jianchao.wan9@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Jianchao,

Not enought input data to give an answer. It depends on mkfs options. =
For example, if flex_bg option is enabled, then several block groups are =
tied together as one logical block group; the bitmap spaces and the =
inode table space in the first block group, so some groups are not =
totally free just after FS creating.

> On 6 Jun 2019, at 13:41, Jianchao Wang <jianchao.wan9@gmail.com> =
wrote:
>=20
> Dear all
>=20
> After I newly created a ext4 fs and check the mb_group,
>=20
>       #group: free  frags first [ 2^0   2^1   2^2   2^3   2^4   2^5   =
2^6   2^7   2^8   2^9   2^10  2^11  2^12  2^13  ]
>       #0    : 23513 1     9255  [ 1     0     0     1     1     0     =
1     1     1     1     0     1     1     2     ]
>       #1    : 31743 1     1025  [ 1     1     1     1     1     1     =
1     1     1     1     0     1     1     3     ]
>                           ^^^^
>       #2    : 32768 1     0     [ 0     0     0     0     0     0     =
0     0     0     0     0     0     0     4     ]
>       #3    : 31743 1     1025  [ 1     1     1     1     1     1     =
1     1     1     1     0     1     1     3     ]
>       #4    : 32768 1     0     [ 0     0     0     0     0     0     =
0     0     0     0     0     0     0     4     ]
>       #5    : 31743 1     1025  [ 1     1     1     1     1     1     =
1     1     1     1     0     1     1     3     ]
>       #6    : 32768 1     0     [ 0     0     0     0     0     0     =
0     0     0     0     0     0     0     4     ]
>       #7    : 31743 1     1025  [ 1     1     1     1     1     1     =
1     1     1     1     0     1     1     3     ]
>       #8    : 32768 1     0     [ 0     0     0     0     0     0     =
0     0     0     0     0     0     0     4     ]
>       #9    : 31743 1     1025  [ 1     1     1     1     1     1     =
1     1     1     1     0     1     1     3     ]
>       #10   : 32768 1     0     [ 0     0     0     0     0     0     =
0     0     0     0     0     0     0     4     ]
>       #11   : 32768 1     0     [ 0     0     0     0     0     0     =
0     0     0     0     0     0     0     4     ]
>=20
> There are some bgs that have 1024 blocks allocated. What are they for =
?
>=20
BTW, I don=E2=80=99t see from mb_group output why 1024 blocks allocated =
in group #1
> Many thanks in advance
> Jianchao

Best regards,
Artem Blagodarenko.

