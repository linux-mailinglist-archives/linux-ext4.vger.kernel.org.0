Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DD510CD67
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Nov 2019 18:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfK1RDT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Nov 2019 12:03:19 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36094 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK1RDS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Nov 2019 12:03:18 -0500
Received: by mail-ed1-f51.google.com with SMTP id j17so6996860edp.3
        for <linux-ext4@vger.kernel.org>; Thu, 28 Nov 2019 09:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MhJbzum0aKZkbCMEaHUdCyUcURmQlqUKG9qVBbw13+I=;
        b=HMOyXkuknV7aHfZp9zdvPIjeIcQQLjebm5XAtiURnWFueYV0Z7cToWLXnURRNa0GEL
         SID++p9vF66MJrchA4Bb/OvvFylxErln2UIZJ8xXIGfdGeoWstEitJ8pubHGud+9TTJo
         1CZwPSqqg7uTCjGoYYZnLTPifzKZLYv3Aj0xPdY9gPt0cXWyPFoo+x8rzF5wwEWBE8cQ
         XFL+bKzqcC2CtymuifiQxShGhG/H1NKj0DoS9Jaf9PH1uPXGniqJz3jaFnq7BcZLaPeb
         g9fYlRYgeMgnSP5+7rPwbESsRwKhgoc9aean135WHfgME/jZZEjnHp1s+CJbIrFh4n0f
         sF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MhJbzum0aKZkbCMEaHUdCyUcURmQlqUKG9qVBbw13+I=;
        b=dMGRS4A9bUvb5pP4Wv2cTRk0G5CzE+QhQ5OwYPMiUK016eRjy3BX8uNAXbyD20nTs6
         anQuvblh2qqqunCSuu2RszTMC9jXJCbN2+vUXHnQ+uspwzvxhzlL4jZ3KURgxLYDl4ao
         S03h2Vt48LJQIZTyq7pmy3TAiKpby6DGCAun2LiF0rDnVdhajDBkydlgcDDIookWynaG
         DVbnKUeoiKSFVsPe8X1okR9KmBLEf28xGWEvdbARLjLel2oQqxlViPXsyEmZGIDUp3FC
         JAzJPETcjZb7klzq0ZjWpQ1cWikaaJWwWDGy7FPKe00qVH/EWcRnQaUa3EOzFseovrMK
         cEgQ==
X-Gm-Message-State: APjAAAW9rmJQd2m2nFw1i3NRbFLChvRRQORdpH5oJSZZNfuFuD6BwHwh
        REt6+q5TwiWay01e/TUfFwjO09NdhrhlPb6tIIGKgw==
X-Google-Smtp-Source: APXvYqzXmpzRVNkRY91beu4EDy9rx/ipWsypamMmioqwA5KjbgwEfcFThjNUWTZDZfHaXzioMFVZbEPruOBACda2C7o=
X-Received: by 2002:aa7:dc0c:: with SMTP id b12mr39175237edu.186.1574960596112;
 Thu, 28 Nov 2019 09:03:16 -0800 (PST)
MIME-Version: 1.0
From:   Meng Xu <mengxu.gatech@gmail.com>
Date:   Thu, 28 Nov 2019 12:03:04 -0500
Message-ID: <CAAwBoOLoHTZGWFw5y_3MoMgZDQ3gCUQrsAO8Z=U4RwV9KyA_fA@mail.gmail.com>
Subject: potential data race on ext_inode_hdr(inode)->eh_depth,
 ext_inode_hdr(inode)->eh_max between a creat and unlink syscall
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ext4 Developers,

I notice a potential data race on ext_inode_hdr(inode)->eh_depth,
ext_inode_hdr(inode)->eh_max between a create and unlink syscall.
Following is the trace:

[Setup]
mkdir("foo", 511) = 0;
open("foo", 65536, 511) = 3;
create("bar", 511) = 4;
symlink("foo", "sym_foo") = 0;
open("sym_foo", 65536, 511) = 5;

[Thread 1]
create("bar", 438);

__do_sys_creat
  ksys_open
    do_filp_open
      path_openat
        do_last
          handle_truncate
            do_truncate
              notify_change
                ext4_setattr
                  ext4_truncate
                    ext4_ext_truncate
                      ext4_ext _remove_space
                        [WRITE, 2 bytes] ext_inode_hdr(inode)->eh_depth = 0;
                        [WRITE, 2 bytes] ext_inode_hdr(inode)->eh_max
= cpu_to_le16(ext4_ext_space_root(inode, 0));

[Thread 2]
unlink("sym_foo");

__do_sys_unlink
  do_unlinkat
    iput
      iput_final
        evict
          ext4_evict_inode
            ext4_orphan_del
              ext4_mark_iloc_dirty
                ext4_do_update_inode
                  [READ, 4 bytes] raw_inode->i_block[block] = ei->i_data[block];


I could observe that the order between the READ and WRITE is not
deterministic and I was curious what will happen if the READ takes
place in the middle of the two WRITES? Does it cause any damages or
violations?

Best Regards,
Meng
