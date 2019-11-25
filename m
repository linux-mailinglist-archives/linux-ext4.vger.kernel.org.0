Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8801085EF
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2019 01:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKYATh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 Nov 2019 19:19:37 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:37575 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfKYATh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 Nov 2019 19:19:37 -0500
Received: by mail-lf1-f43.google.com with SMTP id b20so9550750lfp.4
        for <linux-ext4@vger.kernel.org>; Sun, 24 Nov 2019 16:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7zSdIdMDyeT1DLu7ulKiBBaqqsr0ryXFbn4o+HABesI=;
        b=Aj87rI15MWnTTa+b8MVog3WlP8sZYxGWzhZqoLfLTnhMjwEz7K6Lt1sj9v96Usy47F
         NjJLvQq46jlCYaQuIrwNNM/ZR9V4y8BLorb8ro2BViRt9Qdso3K1YRIaR668mh6HO2vL
         iNxCRiw6isozv6L+1TWhSrdiNTk4pBtacOgxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7zSdIdMDyeT1DLu7ulKiBBaqqsr0ryXFbn4o+HABesI=;
        b=gQr5ODVeAShJ4tVVybit8+bmrheLnIbRPwbXoDLrlpLL1qmXDs4zz+JWByC+GVB3TG
         Y4DB+vspVFP/izpVkH+Uk+LbXynrxzNW2pIqCwISw8vLMQVPLn0ZfyFlSCwF3eXsNut8
         uO6xgso4WFS8N1W+uuMP8XrXqfpGGFeWrTqoU0/uUb92QvWHJPmQKh4BgCHGM6j29JTa
         ucW8nVsZ5Toh7l/4crZ0Nc6VaKOtwD2zFmw1P25dY2miJtqGGV30xqzE/qPNNjc1Skj9
         eJVB/JkZq0iJc6oWIXXOmtTtFi/40oXc0WsYE0S8n64aud+c18iBLpToFLP/0FpWYSdS
         0Bcg==
X-Gm-Message-State: APjAAAV7XWH9gILCp5VKg1yVApjOPtqWo7H9lt7V6Nb+rZl1bKgbx4Hn
        U1m9M+rQFSsLpjcGoM+uZH0zYhHZllM=
X-Google-Smtp-Source: APXvYqzJFOj3PC0g874UsitvnXuVw8JL1l9AFX5cm4ncTIgwsmXQ8bQSswvEFFBRSG9gIHvlcUmyVg==
X-Received: by 2002:a19:7b18:: with SMTP id w24mr18989566lfc.48.1574641173642;
        Sun, 24 Nov 2019 16:19:33 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n23sm2290589lfa.41.2019.11.24.16.19.32
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2019 16:19:32 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id q28so9548490lfa.5
        for <linux-ext4@vger.kernel.org>; Sun, 24 Nov 2019 16:19:32 -0800 (PST)
X-Received: by 2002:a19:4949:: with SMTP id l9mr18141890lfj.52.1574641172100;
 Sun, 24 Nov 2019 16:19:32 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Nov 2019 16:19:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivmk_j6KbTX+Er64mLrG8abXZo0M10PNdAnHc8fWXfsQ@mail.gmail.com>
Message-ID: <CAHk-=wivmk_j6KbTX+Er64mLrG8abXZo0M10PNdAnHc8fWXfsQ@mail.gmail.com>
Subject: Unnecessarily bad cache behavior for ext4_getattr()
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b6673f059820b78e"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--000000000000b6673f059820b78e
Content-Type: text/plain; charset="UTF-8"

It looks from profiles like ext4_getattr() is fairly expensive,
because it unnecessarily accesses the extended inode information and
causes extra cache misses.

On an empty kernel allmodconfig build (which is a lot of "stat()"
calls by Make, and a lot of silly string stuff in user space due to
all the make variable games we play), ext4_getattr() was something
like 1% of the time according to the profile I gathered. It might be
bogus - maybe the cacheline ends up being accessed later anyway, but
it _looked_ like it was the whole "i_extra_isize" access that missed
in the cache.

That's all for gathering the STATX_BTIME information, that the caller
doesn't even *want*.

How about a patch like the attached?

                 Linus

--000000000000b6673f059820b78e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k3doopcr0>
X-Attachment-Id: f_k3doopcr0

IGZzL2V4dDQvaW5vZGUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4dDQvaW5vZGUuYyBiL2ZzL2V4dDQvaW5v
ZGUuYwppbmRleCA1MTZmYWEyODBjZWQuLjYxN2RjODgzNWY1ZiAxMDA2NDQKLS0tIGEvZnMvZXh0
NC9pbm9kZS5jCisrKyBiL2ZzL2V4dDQvaW5vZGUuYwpAQCAtNTcwMCw3ICs1NzAwLDcgQEAgaW50
IGV4dDRfZ2V0YXR0cihjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgc3RydWN0IGtzdGF0ICpzdGF0
LAogCXN0cnVjdCBleHQ0X2lub2RlX2luZm8gKmVpID0gRVhUNF9JKGlub2RlKTsKIAl1bnNpZ25l
ZCBpbnQgZmxhZ3M7CiAKLQlpZiAoRVhUNF9GSVRTX0lOX0lOT0RFKHJhd19pbm9kZSwgZWksIGlf
Y3J0aW1lKSkgeworCWlmICgocXVlcnlfZmxhZ3MgJiBTVEFUWF9CVElNRSkgJiYgRVhUNF9GSVRT
X0lOX0lOT0RFKHJhd19pbm9kZSwgZWksIGlfY3J0aW1lKSkgewogCQlzdGF0LT5yZXN1bHRfbWFz
ayB8PSBTVEFUWF9CVElNRTsKIAkJc3RhdC0+YnRpbWUudHZfc2VjID0gZWktPmlfY3J0aW1lLnR2
X3NlYzsKIAkJc3RhdC0+YnRpbWUudHZfbnNlYyA9IGVpLT5pX2NydGltZS50dl9uc2VjOwo=
--000000000000b6673f059820b78e--
