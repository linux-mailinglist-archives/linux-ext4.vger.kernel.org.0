Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6486D12DAD2
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 19:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLaSGB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 13:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfLaSGB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Dec 2019 13:06:01 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7722A206D9
        for <linux-ext4@vger.kernel.org>; Tue, 31 Dec 2019 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577815560;
        bh=0JMKJaSZYwomuwjq5Cf4y6TiZEXGq4LiRZOow6AsjOw=;
        h=From:To:Subject:Date:From;
        b=CCs51VehB2nzOe36vk2KxWDQRh+bGc+qtWV4rS4TB54FfYShaGHxy+BAFst42h/xY
         KonhOfK8Xqk/B9vgnryNNx4YmT881KP5/NdYNMW7f0p7JR7FmpA/+DbMIDQIJnCiju
         4UDRuPCVGRQjyNe6llkQpvrSCeTUDC0aOy3uufio=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 0/8] ext4: extents.c cleanups
Date:   Tue, 31 Dec 2019 12:04:36 -0600
Message-Id: <20191231180444.46586-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This series makes a few cleanups to things I noticed while reading some
of the code in extents.c.

No actual changes in behavior.

Eric Biggers (8):
  ext4: remove ext4_{ind,ext}_calc_metadata_amount()
  ext4: clean up len and offset checks in ext4_fallocate()
  ext4: remove redundant S_ISREG() checks from ext4_fallocate()
  ext4: make some functions static in extents.c
  ext4: fix documentation for ext4_ext_try_to_merge()
  ext4: remove obsolete comment from ext4_can_extents_be_merged()
  ext4: fix some nonstandard indentation in extents.c
  ext4: add missing braces in ext4_ext_drop_refs()

 fs/ext4/ext4.h         |  11 ----
 fs/ext4/ext4_extents.h |   5 --
 fs/ext4/extents.c      | 143 +++++++++++++----------------------------
 fs/ext4/indirect.c     |  26 --------
 fs/ext4/inode.c        |   3 -
 fs/ext4/super.c        |   2 -
 6 files changed, 45 insertions(+), 145 deletions(-)

-- 
2.24.1

