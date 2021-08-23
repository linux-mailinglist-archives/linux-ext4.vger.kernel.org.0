Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAB33F4DA6
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhHWPmg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 11:42:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37254 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhHWPmf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 11:42:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 144EB2001D;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629733312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Lo5ACFFy6jjOqStLjngzVVVJfa4fnQM2VExUEs/Wo1c=;
        b=rEPSSVIDh/giDfgl0G620BSSt6Mf45xgVUioeJgFPcNG1Dyqll4t7unxTkaWye9py1eBWf
        qi2gH0SzvzrGjaFjnCNI8jzEjQ2iLroAZgpP+DLadE31xh2f1H8NxikcC1J33xoGqOLnuM
        SKB9pS2Ujl2gcgbIGZXEXrUF+nReUBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629733312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Lo5ACFFy6jjOqStLjngzVVVJfa4fnQM2VExUEs/Wo1c=;
        b=UuPuGhwVxk4jOlfmUSm0qFQV8tm4c5dN9aXncHeFXRNP8GqkBEkFkLNcBlYJ4JiFwujbCU
        WEJRJZ2JJ9aTfFBg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 05DA9A3BB9;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BEC9C1F2CC8; Mon, 23 Aug 2021 17:41:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/8 v2] Quota fixes for e2fsprogs
Date:   Mon, 23 Aug 2021 17:41:20 +0200
Message-Id: <20210823154128.16615-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=664; h=from:subject; bh=DxsO2R+7RZDCl4+T/GytLSxUdpEniRiW7NC4yI79HZc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhI8GaXyHt5Q2QHJkDyBj33W743xJHIYiUr1CjV1HD LBYMXRyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSPBmgAKCRCcnaoHP2RA2cB4CA C9WM/KQhuz1cxYrDMhWImJSn+9nUF/sQfdT9auR7QCoD49bOBa+rFkt/dSRnPO99FsxMnojSzZH122 oXbkOIS83QFEzzLht3pMnJAzYWoC39c1qGZYmDdaK+xrIAOrMKfjXE34ZBGe/nV4vvdbjcNLkPJ4fa BPzz+kixkxL5Lykj4n0YxZSr1IcoTjBQH+JKDgcUA/15+Pa0oCEfHUS8TqPXhapF0AWh0d8nQrELee fmNheENja9A9j1m2GxTaNbKpr5FSBN2d+INtM6o9xUifhf1iTGwbpFo5KLKEJg1IK0Kg5PCXAUoqtK FX1c05Efg4jZFNpgjWIBJR6sJpSbgO
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

here is next revision of my quota fixes for e2fsprogs. When addressing the
e2fsck regression Ted has pointed out, I've noticed another serious bug in
e2fsck support for quotas where it just nukes existing quota limits when
replaying orphan list. A fix is now included in this series together with
expanded test to catch the problem.

Changes since v1:
* Rename the functions so that names match functionality
* Fix e2fsck regression when processing orphan list
* Fix e2fsck bug to preserve quota limits over orphan processing
* Expand test to verify quota limits are properly preserved
* Fix quota output headings in debugfs

								Honza
