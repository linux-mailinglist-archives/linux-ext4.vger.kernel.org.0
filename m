Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D4A7263
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2019 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfICSPx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Sep 2019 14:15:53 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:44215 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfICSPx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Sep 2019 14:15:53 -0400
Received: by mail-qt1-f178.google.com with SMTP id u40so12481796qth.11
        for <linux-ext4@vger.kernel.org>; Tue, 03 Sep 2019 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZDlL/rClenmR6VE0siOjkh2adGJaq3G/Ew8VVSvBXFQ=;
        b=n0858ChSPnxrWGFDol00Hg+lvhh8YIO8MRJ/Doeyn7XYhB2te+tGPYU0t/DifI5YC8
         bdhHUVkfoaYtcIL4eluO4sMEL+cSQsvT9qZXaURgkrEfbuCSCm0hcfmR+os3wOax7yZT
         QKYB2d5Zl3Gng+m1l6H/UI2pLc0Z0zQC9SFD1UGBDgQ/MyoG7i/CCChWhBao5TRTVkHi
         yvvTzimrjKOuepwnAo7DUVbpCZYvuOHIYsH/R7lvdqfSOAU6EVysLASUq7+9RLwrBvBl
         vbyQ+EFCCft4ZJ8LcKnxhWbFEtwVY7QQbpGIWQ+ny5TioowSH2W0AqA6VjqscIIAM94g
         pEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZDlL/rClenmR6VE0siOjkh2adGJaq3G/Ew8VVSvBXFQ=;
        b=tfKbDko3lnmhtxsCnaKphunEiMgL1MWFjH/o47r73vkuS+WkH14tfgaxDo7Z0j4Iqz
         WoYUCh7ld3dt9qmdzzy08mkkZpnJQi1tuSG3aveR22BHDGf5qkm5FCClpIAUHD9ZjyA4
         EhagY32BcplJTLI3+C1jSJ0Eqi4RUKHuGF0EKCJrkTc+/Aou9dErR64rmBW+Mzmg7cLB
         tbMD/ThyIM9gfmjjgLjF80rU4LeGEQyyKj1O7yk6BxAoqNwnp0UPZ+polnfKVYMP6p56
         dqRqWAIHPWzisbEPsi6V973K22RUkfUQEUn80enGQEu6qEHY95zOoNlpjIN2pPN5nAl0
         5+ww==
X-Gm-Message-State: APjAAAVROI6yaiatgp19hWOzgvrCmwQKGP6fb+RFux2GjxjXIvXEBDC7
        BH4XZxGeBiAWagDfc4JcsG1kfw==
X-Google-Smtp-Source: APXvYqzCEa99BG6PuKfmnoHXjuYaVJwIQTmH16PtTHa3ItgXKrqdjCBIygS49mE4aOzrypG8zKA/+A==
X-Received: by 2002:ac8:5204:: with SMTP id r4mr16151539qtn.332.1567534552343;
        Tue, 03 Sep 2019 11:15:52 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u22sm8086968qtq.13.2019.09.03.11.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:15:51 -0700 (PDT)
Message-ID: <1567534549.5576.62.camel@lca.pw>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
From:   Qian Cai <cai@lca.pw>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 03 Sep 2019 14:15:49 -0400
In-Reply-To: <CABeXuvq7n+ZW7-HOiur+cyQXBjYKKWw1nRgFTJXTBZ9JNusPeg@mail.gmail.com>
References: <1567523922.5576.57.camel@lca.pw>
         <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
         <CABeXuvq7n+ZW7-HOiur+cyQXBjYKKWw1nRgFTJXTBZ9JNusPeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 2019-09-03 at 09:36 -0700, Deepa Dinamani wrote:
> We might also want to consider updating the file system the LTP is
> being run on here.

It simply format (mkfs.ext4) a loop back device on ext4 with the kernel.

CONFIG_EXT4_FS=m
# CONFIG_EXT4_USE_FOR_EXT2 is not set
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set

using e2fsprogs-1.44.6. Do you mean people now need to update the kernel to
enable additional config to avoid the spam of warnings now?


