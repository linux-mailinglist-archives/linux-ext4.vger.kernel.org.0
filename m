Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B3FFCEC
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 02:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfKRBuQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Nov 2019 20:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfKRBuQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 17 Nov 2019 20:50:16 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C5D206D6
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2019 01:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574041816;
        bh=/hmyvsYmp9pfLjt/1prN7yyQkDHGpwaL+UIcNMcNe4M=;
        h=From:To:Subject:Date:From;
        b=TIKzkZSS7lofjuYB6ewTgNczC/MWLMEXKK2x/wf6CYC84vKo+HTc8Z7Fw0bix3lyZ
         djgFV1aaXLhaupr38xK9OU1F1QGbP5gnH8JseZNIsXYdzqdiZJs5zUdIabAYiG8lVo
         fZWh1cXPgKxyqE/o81vDZzu1hiNKDdEPV+V7wRw0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [e2fsprogs PATCH 0/6] chattr.1 updates
Date:   Sun, 17 Nov 2019 17:48:46 -0800
Message-Id: <20191118014852.390686-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This series updates the chattr(1) man page to document the verity file
attribute ('V'), improve the documentation for the encryption file
attribute ('E'), and make a few other cleanups.

Eric Biggers (6):
  chattr.1: document the verity attribute
  chattr.1: adjust documentation for encryption attribute
  chattr.1: add casefold attribute to mode string
  chattr.1: fix some grammatical errors
  chattr.1: clarify that ext4 doesn't support tail-merging either
  chattr.1: say "cleared" instead of "reset"

 misc/chattr.1.in | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

-- 
2.24.0

