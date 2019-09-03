Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E91A6CBD
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2019 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfICPSp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Sep 2019 11:18:45 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:38358 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbfICPSo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Sep 2019 11:18:44 -0400
Received: by mail-qt1-f181.google.com with SMTP id b2so16882661qtq.5
        for <linux-ext4@vger.kernel.org>; Tue, 03 Sep 2019 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=41G2aVZ2UIyZbN+qqTnEEAlUQce0psMlCxkdXRi0woc=;
        b=gGAhjK8E3JYUeHFI+hfwuyPjgS754Z/R0J/ID1JCj50+hthV15w4vhsy7SXXBUNkCf
         eGqZI3wy4vUOxlFjmxqqMroyQq/VghmOQASc0xovzbPzL8uBZZA4dDesrgsFmI4g25er
         frH1b85rDzemofj4z+F8adqllRrbHnZERhDAmMx2tyOqj36b+5U3IsJaobQSo6dVDsZC
         40nSEISIvq/KCWBmk8ZO/IdffaQqByrI2ZemeLR9qRFXJyZiZYMiwnbOnPlsXAacBr6n
         WwAX8wEGbiDKFCY0n9oI1D+txFfX+HU/4sApuv0c8GB5f8U7UXesIBUGK96Qbp9TgGsr
         M1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=41G2aVZ2UIyZbN+qqTnEEAlUQce0psMlCxkdXRi0woc=;
        b=nIfEMwUgJXiKrDrc70M0VsFBMyp/aaNOwNQRfROnrefA48fRhBNn5p3Taez4G7scZX
         a3icxK0LGaS0aJVu05pxrUMV0MUSQpqP5bTQVZlfeCCuy0PvaaZnKnTvL8+YXJb+WC5Z
         fezlSSl3SiOyYXwXOairKCSEkjIiXkWKKl3DIZGB58HjcYhnyGlekL80sqMjnDp8cKPZ
         VQkVQD+JNVqPD2+ucmrHrzVWS3pMkOs1AZBDdqu3801R10O5BanVq4ADt7qTaL34JDeP
         YgGDCzcK+N7Y78x6gxjdAYsWUJ5uM/mlpwsu71vrBVAnt0zFF/B5XBwbHC4jLJmIknYi
         OX9w==
X-Gm-Message-State: APjAAAVQhOeWZLXTGrgGzfw5FuDo/N5S/jIytUHNtffrzCzoa4LtPvwt
        xbDZiX6T0WYAhhn2k1Wo+5gtJA==
X-Google-Smtp-Source: APXvYqx+zxtcnskjuSmXfYN7TaHQhfcYZA+gg2du0ohxxNXHWZJliwkamJBZLwCZf0UiLCwKsdnE7A==
X-Received: by 2002:ac8:2392:: with SMTP id q18mr9332116qtq.261.1567523923826;
        Tue, 03 Sep 2019 08:18:43 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f83sm802705qke.80.2019.09.03.08.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 08:18:43 -0700 (PDT)
Message-ID: <1567523922.5576.57.camel@lca.pw>
Subject: "beyond 2038" warnings from loopback mount is noisy
From:   Qian Cai <cai@lca.pw>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 03 Sep 2019 11:18:42 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://lore.kernel.org/linux-fsdevel/20190818165817.32634-5-deepa.kernel@gmail.
com/

Running only a subset of the LTP testsuite on today's linux-next with the above
commit is now generating ~800 warnings on this machine which seems a bit crazy.

[ 2130.970782] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#40961: comm statx04: inode does not support timestamps beyond 2038
[ 2130.970808] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#40961: comm statx04: inode does not support timestamps beyond 2038
[ 2130.970838] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#40961: comm statx04: inode does not support timestamps beyond 2038
[ 2130.971440] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#40961: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847613] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847647] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847681] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847717] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847774] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847817] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847909] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847970] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.848004] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.848415] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2134.753752] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753783] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753814] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753847] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753889] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753929] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.754021] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.754064] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.754105] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#12: comm statx05: inode does not support timestamps beyond 2038
