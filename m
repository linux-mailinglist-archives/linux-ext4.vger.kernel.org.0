Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E3FC071
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 08:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKNHDl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 02:03:41 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:34398 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbfKNHDl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Nov 2019 02:03:41 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 2790C2E0B08;
        Thu, 14 Nov 2019 10:03:38 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id eGSxQyNzyJ-3bteExrw;
        Thu, 14 Nov 2019 10:03:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573715018; bh=svihJ3/3cnY/1btnNipQz/Ijg4CCt1aoyogk0lSbG3o=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=lOgGxknpwF/oL41IeWr1HVWAfe00UMXfNRLYnRWx0BeZC4vX0D5QZo+8xWVLOGqPx
         neyzHAq5U8ORFZDTCbrcuIkNRXU1yy2I+IIsOCZHe6E7lbVCNvMd+Y/1gTnQ+wNddF
         Ld5pXoszSZ4EpoHsKzhAcdMXJcPbP6dg/q4zJ9cE=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by vla1-5826f599457c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 1C2DjkEI6P-3bVOWrMS;
        Thu, 14 Nov 2019 10:03:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH 0/2] ext4: Workaround trace event flag decoding issues
Date:   Thu, 14 Nov 2019 07:03:28 +0000
Message-Id: <20191114070330.14115-1-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Trace's macro __print_flags() produce raw event's decraration w/o knowing actual
flags value. For example trace_ext4_map_blocks_exit() has two __print_flags
tables, one for EXT4_GET_BLOCKS_XX, and second for EXT4_MAP_XXX

cat /sys/kernel/debug/tracing/events/ext4/ext4_ext_map_blocks_exit/format
..
print fmt: "dev %d,%d ino %lu flags %s lblk %u pblk %llu len %u mflags %s ret %d",
....
 __print_flags(REC->flags, "|", { 0x0001, "CREATE" }, { 0x0002, "UNWRIT" },...
 __print_flags(REC->mflags, "", { (1 << BH_New), "N" }, { (1 << BH_Mapped), "M" }..

First macro expanded w/o issued because EXT4_GET_BLOCKS_XXX flags are explicit
numbers, but second macro stil contains text fields because it depends on
implicit enum values. It is important to note that this is exact representation
of event's binary format. This means that  perf-script can not decode bintrace
file because BH_XXX is just a text token which is unknown to userspace.
As result perf fail to decode it and fallback to dump it as raw hex number.
For example:
  ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 12 flags CREATE lblk 0 pblk 34304 len 1 mflags 0x60 ret 1

I tend to agree that this is likely to be trace API issue, but it looks like that
EXT4 is the only subsystem which is affected. Others already workaround this by
using explicit numbers. Let's do the same trick.
TOC:
   ext4: Use raw numbers for EXT4_MAP_XXX flags
   ext4: Fix extent_status trace events

