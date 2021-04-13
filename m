Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EB135E897
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Apr 2021 23:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348552AbhDMVxi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Apr 2021 17:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhDMVxe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 13 Apr 2021 17:53:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA27461222;
        Tue, 13 Apr 2021 21:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618350793;
        bh=yB0HkGpIKD/9kn1kseH50pxnyI/f5O1CKVyt7TEmSAc=;
        h=From:To:Cc:Subject:Date:From;
        b=d7a+lg+k4xu9bJl+9yt0s63822oO8+mkPVvPtg7nq1TWnqFhaJYbnsr6lLc3tc5Bv
         1d+s+6T9ep9Q6VKeFDz2drjLMOA6ugigyF1L+BFzJWQuA+367/aAcM+tcfHLffkCZJ
         DtWDjGc/OTAixszj/a5PUqZxL9hihyKech3htnyjpb7pglpjwYTGrtu29FbZ2ok8c3
         pu+78Dt8gf5HKa0oP4Eu3f47fpPymMnTWiLprbXsS2lJ8VEC5aavIUZcUxnNqSCNdj
         4S1RdEDhlJq9eEGpvT8dyi7wguATRQd9TtXPrbHoAJwT0Y65mv/9iu7jpTgsvaZ/OH
         w7IFrRiTJPTpw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Rosenberg <drosen@google.com>, linux-ext4@vger.kernel.org
Subject: [xfstests-bld PATCH] test-appliance: un-exclude encrypt+casefold test
Date:   Tue, 13 Apr 2021 14:53:00 -0700
Message-Id: <20210413215300.10700-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This is needed to test the encryption and casefolding features in
combination.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../test-appliance/files/root/fs/ext4/cfg/encrypt.exclude      | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
index b7f6ea3..20abf5e 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
@@ -30,9 +30,6 @@ generic/587
 generic/600
 generic/601
 
-# encryption doesn't play well with casefold (at least not yet)
-generic/556
-
 # generic/204 tests ENOSPC handling; it doesn't correctly
 # anticipate the external extended attribute required when
 # using a 1k block size
-- 
2.31.1

