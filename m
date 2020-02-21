Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F802166F32
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 06:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgBUFfQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 00:35:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59691 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725973AbgBUFfQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 00:35:16 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01L5Z8mu022065
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 00:35:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 49BCB4211EF; Fri, 21 Feb 2020 00:35:08 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Suraj Jitindar Singh <surajjs@amazon.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2 0/3] Fix various races in online resizing
Date:   Fri, 21 Feb 2020 00:34:55 -0500
Message-Id: <20200221053458.730016-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I added __rcu decorations to s_group_desc, s_group_info and
s_flex_group, and this turned up quite a few places where we were
missing an rcu_dereference.  A number of them weren't strictly
necessary, but suppress warnings from the sparse code analysis tool
--- and sparse did find some places where the missing rcu_deference
could have led to some very hard to find bugs!

I folded the "introduce macro sbi_array_rcu_deref() to access rcu
protected fields" patch into the first patch, since we now need to use
the array in many more places.

Suraj Jitindar Singh (2):
  ext4: fix potential race between s_group_info online resizing and
    access
  ext4: fix potential race between s_flex_groups online resizing and
    access

Theodore Ts'o (1):
  ext4: fix potential race between online resizing and write operations

 fs/ext4/balloc.c  |  14 +++++--
 fs/ext4/ext4.h    |  30 ++++++++++---
 fs/ext4/ialloc.c  |  23 ++++++----
 fs/ext4/mballoc.c |  61 ++++++++++++++++++---------
 fs/ext4/resize.c  |  62 +++++++++++++++++++++------
 fs/ext4/super.c   | 105 ++++++++++++++++++++++++++++++++--------------
 6 files changed, 212 insertions(+), 83 deletions(-)

-- 
2.24.1

