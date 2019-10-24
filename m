Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E7E33E4
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2019 15:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502540AbfJXNXd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Oct 2019 09:23:33 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:41820 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502538AbfJXNXc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Oct 2019 09:23:32 -0400
Received: by mail-lf1-f42.google.com with SMTP id x4so12843740lfn.8
        for <linux-ext4@vger.kernel.org>; Thu, 24 Oct 2019 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=zd3gqhuIRD+EIRndf+SmDBrEPsFc0s2TNeeNdYV60II=;
        b=aar+YxQEfNoO9pb3tVll4bn5ygE/5+C5Wh8HwuNu5aveJNt3iP/NfIgzBzqZIwbjr4
         ZoA4l27u4SbMBX76qXbtbQNehnEI3p1pJ1QnJ+fTYC/yJqUFZjpanJR+gvl86yVHvu3k
         D/0MguX+Hx8PXwaZQmKvYMhSKXU1n2aJ70nC/vgAMJR+rQaONBJ0PL0tn34hjMSv6Hjx
         xK5cYwlqXyvI2x1XqjT4bVqGKk47es1sAmSBqFMB2knMCOSU4MAciF5BQFN7J8NFXepD
         sSv1m+TgpHj6QUy8nR1fQSsQIzhHRy4YjvibrNg7gA633XSWJSkDfM6eBQTQQC9f4Zyo
         gONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=zd3gqhuIRD+EIRndf+SmDBrEPsFc0s2TNeeNdYV60II=;
        b=CaUol+Kr2oN7p9mYENPHAfmcVlV0reEUpppC2POyu29kNdphmrJsmF+pj/UZ1FYwJD
         iWfXva5+71+Mn2xmxGb6zU0fr1vhxlatQ8f1sndchip9zUZ36yORdq+Bzp9TiwaTi8NW
         dpPX1mVVdnrSwpg2fOGrIjtQ75xmY+2rdsoesgRdC5sOzkmzx2Hf0LAA3hW6KFb5sJys
         BGulhJCaCc5RB7VmcWuzV3v8mpfoTM5roRr2r5dRx9RJUZWbTpl3zDXL8cpltYRM7tWH
         LDkTb1Z/mya+SiQdk0jxHMOWesAnYryZVflBkfbpWxv4CBa5CZjoLgzSkLEt+/iVm9AU
         z+tQ==
X-Gm-Message-State: APjAAAVfesPUnYInRxpUQNwJEZt/b/nmJZ7mDWTIfiNkkhs1ZCp5VMUx
        JJXPJ5B9HjG3GahWL/S7p1s32qSc4iv8gg==
X-Google-Smtp-Source: APXvYqyPtuiWajQ0MktDddf/rIMKX6bfgZz8jBbXwq2GGVSzrOWWzKVCZZvReIPSigqqJ6IOFwYPxg==
X-Received: by 2002:a19:6a08:: with SMTP id u8mr28411705lfu.74.1571923410446;
        Thu, 24 Oct 2019 06:23:30 -0700 (PDT)
Received: from [192.168.43.113] ([95.153.130.220])
        by smtp.gmail.com with ESMTPSA id y8sm10174448ljh.21.2019.10.24.06.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:23:29 -0700 (PDT)
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: 1024TB Ext4 partition
Message-Id: <8A6F6DF3-F920-4291-91C2-E4AAF1E63ADE@gmail.com>
Date:   Thu, 24 Oct 2019 16:23:15 +0300
Cc:     Andreas Dilger <adilger@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Lustre FS successfully uses LDISKFS(ext4) partitions with size near =
512TB.
This 512TB is current "verified limit". This means that we do not expect =
any troubles in
production with such large partitions.

Our new challenge now is 1024TB because hardware allows to assemble such =
partition.
The question is: do you know any possible issues with EXT4 (and =
e2fsprogs) for such large partitions?

I know about this possible problems:
1. E2fsck is too slow. But parallel e2fsck project is being developed by =
Li Xi
2. Block groups reading takes a lot of time. We have fixes for special =
cases like e2label.=20
    Bigalloc also allows to decrease metadata size, but sometimes =
meta_bg is preferable.
3. Aged fs and allocator that process all groups to find good group. =
There is solution, but with some issues.
4. 32 bit inode counter. Not a problem for Lustre FS users, that prefer =
use DNE for inode scaling,
    but probably somebody wants to store a lot inodes on the same =
partition. Project was not finished.
    Looks nobody require it now.
   =20

Could you please, point me to other possible problems?

Thanks.
Artem Blagodarenko.


