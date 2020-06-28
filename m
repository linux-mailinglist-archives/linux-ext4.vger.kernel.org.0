Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742BD20C813
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jun 2020 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgF1Mmm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Jun 2020 08:42:42 -0400
Received: from mout.web.de ([217.72.192.78]:46909 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgF1Mmk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 28 Jun 2020 08:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593348147;
        bh=npulf07zoEOS6mrZ7kUQr1zyXg++JzWm5MGqz6djhHI=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=eWBbOYTxXxQGhJ/A6LAwtJdwE6LGv0kaE7c6GxyPftIRt1lpTrWkedgIhX+Rs+c18
         Cyo5l/Fo1UN3/yLW/EgkCGXBIxMrMhqFPrV8+ZlzXcQVU0Ao/nB+kA1NZLHgLjHHza
         HYc1EfMsCiw4z4QcBo1QFNeuJYGaUKj3rkq0Is6o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.52.166]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWj2N-1jJRyy2whv-00XsiD; Sun, 28
 Jun 2020 14:42:27 +0200
To:     jiangying8582@126.com, linux-ext4@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] ext4: fix direct I/O read error
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f40db056-51de-8332-473a-f020d0976c0a@web.de>
Date:   Sun, 28 Jun 2020 14:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DWIB516VUkxjxrUPS7ibzg4GoIkmnwlRrNMBdlzcOEWEQXZ6o/Y
 lmtGEu+T2Cok+bFeFjVnZitEm+m2BpIOdB8U9rEAJI3rw5zlIrpVh2gdK8zbfFdJ1PMY7YV
 qNsa1RZ4dlVWctXm7ogAJDri2LbC0tGTkBUSauo78z57adU7syxNXpZQCNQ7qw8a8k4OINE
 R3ynD4fqPKq3A/wyPEvyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+R3qBd12JO0=:ncEQ7ERAS6GjgRYWiUDLPl
 lk4MZ/zNxvzK2XTVDOGUp2djvPIDZwsa0kCqKgDXO7tkM1s8qjZZrJqo3k2/t7hrV2RAIF0rU
 1hCZnp5aWv1jvd//drEpQ1uddhnXdXjZ6WHSxpS9zx/VSizAb5uslRLhtXOlZSwZYBuOH6iCT
 7QUW4gdtc1ECgmdXU03olS9nuQFPFpwaRnHWOGJwNJgws+/QDIzj/VOU82BVWdHZTcUk4pukm
 J/NY0N6wr1HQEtePlxstNE5nh/AKui6pJWPvYJoFYSqhe+Zohpn3NNw7NoOePPUNDZSJeMTNN
 ZUip25mH8gFAM/aYIGAh1SLwnEnRsj1r+aFf26TDrAvwkFHAcj5a00sEDhlC5FN0YS2EqCz1Y
 LmUtpx9roO6fphVAjgx9C6kKlxQUrGgUefkTNTMfCC9OASZBchMhAOux7mum7T0jYLGc0Rdn5
 w5aO2/VYW1SpXfW4XQT7d716mojHtPUyWr5+JMQkl6tnsoPY0h7umy2ZQSjMskCAyx6c1rYa8
 mZS3M1P3zKag8EAFSd3c17aO5DgkXcb6VSU2+UuzPss/1VsVjpzq7jydwVsamB5WrNkV/+ECf
 thXIEImlrq+w9WO1pf628alREovv1fbj9iE0i3rRdY+5jdscUXqwld25I3Z7IEYPB9vvh5pMd
 HG6ZPx5z939S8pCAA7FMq5wIZsXCronZLdrzSRQwhKUyWocrdRcY+Pt4mmz/1Mzh/eFe2eNUc
 xiOpuEnPLNMLu/l89gWdAbckplpZvKiHjWQoNSLzsCwuEVghmPmXkhfU3RJDHPm4vE7/vkZ7E
 UjKsi2ZFtXnqCGBW/yJ4VMXvMW/hHAMKqV5GEik6El9Kjx9cBFrpjXUmFZZ8XY7NxMnqRSyK6
 IWegc90WMinZBwzeIICW8i4vQokHeztA8zQFOjYh6JT4ud938JUuCAK0uVHtYFp3BpPpS3eIA
 Wtq4imWj67/bZ8tR1hfAfQg9qXbxstiawg8cpOuaWYqA0bJEecGvudReskdGFzbLrLcmNxBII
 lhSrA9MRnuUNo6gwTOboIM1EjaN5mFuLmt9Op2lJYYJePjoV42JJ01akNB8/j+8kboC+92ylo
 3QS8VD0DJnj26JWrCy1ntcFW3bMRN5lDr7AWhkv3kiEH8ryCDIphoDR8nIIJVekkr16fXAeWu
 n21gML1G9LIL3gER4dn1lze2pe1IkuTqzmKNopHmhYViifrEZQhtTzdYvmN5cLYvPtk3MuBuk
 /TUeE0BujhFS32tlM
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Signed-off-by: jiangying8582 <jiangying8582@126.com>

Please use the real name for your contributions.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D719fdd32921fb7e3208db8832d=
32ae1c2d68900f#n431


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
