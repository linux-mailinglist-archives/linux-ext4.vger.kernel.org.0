Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F513E8EA1
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhHKKbg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 06:31:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48616 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbhHKKbg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 06:31:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0E316221D1;
        Wed, 11 Aug 2021 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=t4ob24jXGVENc5AMMPpl0fgYrGHtpcX2WGGnWkvF4YQ=;
        b=o2u4pNHZ6Motj82j+iW9EfTVqlVJCOpVKyxgr3fn8zZyfPpKCKzJ2bJqOSpvRbjy6aIpt9
        yFPQI1uSaFqdspJzZkHE/Zt2XinhxN1EjYaUAfQnTdcI33yvKkVfgK7zyxP/8oy/iv8v6F
        NqrLRM6Sk26Utd/kflV0oHGYsn3HwYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=t4ob24jXGVENc5AMMPpl0fgYrGHtpcX2WGGnWkvF4YQ=;
        b=vQ220Hs5yDI51/sXlSnb/5oW8eE5XgNlD4vyEmDRjrivl1gmDoKkkgdPZ2rRbofdLePWlR
        NBBxIcQaNxV7cZAQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 048EDA3C08;
        Wed, 11 Aug 2021 10:31:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D44D71E6204; Wed, 11 Aug 2021 12:31:11 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v5] e2fsprogs: Support for orphan file feature
Date:   Wed, 11 Aug 2021 12:30:49 +0200
Message-Id: <20210811103054.7896-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; h=from:subject; bh=Da02mPJk0z6+1abwV9g+MYg91SClRzQrfBYK2kapryc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhE6bYxjAWWZDLNSpzC7KIwBA+B8Xc2GUDlfDPKOys MVEUNn6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYROm2AAKCRCcnaoHP2RA2aImCA DsuTLRbIoyhdkhckSsq4v6QzCwlg/QwXMMmXnMkvbErtd/q0ZxBxfxTzQApw0/y1ExqlBa03pNEzdV 5huto14sWUdvrRb3Aq6D14c+lAhV5gZzYHDancoxzck+1j0PnWnqQHAMgRBiGzcuqHqPsrkr32kdvA hBVAa1y6zwSVHQzpDPNCxQVwUEVLuG/QsmFuMyslF1PHqF/Z+oX0rE3IbJ0yNLfPWzlEDjni8O1TtT vClJ4jl+Vf+5UVYjHRLxPUSTy0YdcNMizXRiiDAurCpcOD3gIsqEnvR5YPZzWzRcShuG8idZPt/Wqk dZwe/us+alY9srbu7S8CTy7qWBliBz
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello,

  This is the fifth version of support for orphan file feature in e2fsprogs.
I've rebased it on top of maint branch as Ted already merged initial fixes.
I've also fixed up some issues Ted has already found.  I'm not aware of any
outstanding issue with the series, xfstests pass fine with it.

Changes since v4:
* Make sure we consistently speak about orphan_file and orphan_present feature,
  not flag, in error messages.
* Do not make orphan_file feature default yet
* Make sure mke2fs does not complain if orphan_file feature got enabled by the
  profile but user decided to disable journal.
* Fixed up value of ORPHAN_PRESENT feature
* Fixed several introduced -Wall warnings
* Fixed e2fsck errorcodes
* Rebased on top of current maint branch (some patches already merged)

Changes since v3:
* updated to compute checksum also from physical block

Changes since v2:
* rebased onto current master branch
* fixed various bugs I've spotted during testing
* added support for debugfs, dumpe2fs, e2image
* changed code to use dynamically allocated inode number instead of fixed one

								Honza

Previous versions:
Link: https://lore.kernel.org/linux-ext4/20210712154315.9606-1-jack@suse.cz/ # v4
