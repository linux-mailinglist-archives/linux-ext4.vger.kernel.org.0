Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCD3371E3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2019 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfFFKlq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jun 2019 06:41:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40601 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfFFKlq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jun 2019 06:41:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so1256700pfn.7
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jun 2019 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=C2Xwg0LTcVtWta6MedAqslGdpCP35r6qoFQeBUfFvJs=;
        b=XRdCqkli/2iJYos16PDRy8iKn4VDYMfWZmYiaBxMpJcGQgKnbogQv8DpdyzArAd2ZC
         +zvQQslFRVkp9Df9iYHOjA4vURm6eOBNJkmNfyRa50kgrBL+1yU1di5HZ8Hey+BWxbvO
         qE3csgFw6eoAQ6l84npYMRtukRfHJvoYHzOoYKHyBhZb4jX2DNaDfQpTtK4ri5CC+XFG
         nSJPbRtlYIxzbIF9LdNA42QOA7c3lANuIpWRFum9D6aNY1aScUlzAbVWv5X4SwEuIDW4
         0JBOt4bBiBOOnuZ0xySEPsQipUaMoG70OPPILH8VHsHPNUFN9SZS1rDLQAkmQhzq81Im
         eySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=C2Xwg0LTcVtWta6MedAqslGdpCP35r6qoFQeBUfFvJs=;
        b=Pzto8qzA84GTBV4uTPS8LUpdIrhQ4pHzXHNp1H1IiP4LCY7yaxaZKLn9Nyqs4z8M9A
         GsaycT3DwLyIVxiPv7w2RVaaftGhdruhi7v5Xr0ey8rA2IC0NQYlH6ShgUyJHUSyG1MR
         dg5+GO7+VhWP5fMNdZGsBz9WKYQLy+3HoI831CgDsHmjHqhLfZcqUFreVZavk93/n8UT
         3nF9uorIagTYEQaGSj+z226r2ItRa0vU/WghKWVn3lYVM2j/EkDnF5+Wnds08M3DhQIl
         hGR+TTQFoBD27j8/ZQ4PIuMNJSows/PWnCE/F4y3z95espee5HUcMOuESQr+hLDzP5a9
         OmsQ==
X-Gm-Message-State: APjAAAXXaS5bLYA67/BARKMangC5eSWcPEMHSP3Wd6XQSdwFtCYTrHQa
        HX3hlDMcD3YdDhTjfzNhaT+tdO32
X-Google-Smtp-Source: APXvYqyhKB7Rp2Uuzl/91/8BlWPBwoEQqKZ2PXU2ynVM8EFemgV0KeHqvldrbTWVxhvOW7DYkNBvww==
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr42070328pjq.134.1559817705342;
        Thu, 06 Jun 2019 03:41:45 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.216.228])
        by smtp.gmail.com with ESMTPSA id b23sm1853562pfi.6.2019.06.06.03.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 03:41:44 -0700 (PDT)
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
From:   Jianchao Wang <jianchao.wan9@gmail.com>
Subject: [HELP] What are the allocated blocks on a newly created ext4 fs ?
Message-ID: <b64110a4-8112-a230-2179-5095aa943af9@gmail.com>
Date:   Thu, 6 Jun 2019 18:41:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear all

After I newly created a ext4 fs and check the mb_group,

       #group: free  frags first [ 2^0   2^1   2^2   2^3   2^4   2^5   2^6   2^7   2^8   2^9   2^10  2^11  2^12  2^13  ]
       #0    : 23513 1     9255  [ 1     0     0     1     1     0     1     1     1     1     0     1     1     2     ]
       #1    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
                           ^^^^
       #2    : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
       #3    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
       #4    : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
       #5    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
       #6    : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
       #7    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
       #8    : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
       #9    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
       #10   : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
       #11   : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]

There are some bgs that have 1024 blocks allocated. What are they for ?

Many thanks in advance
Jianchao
