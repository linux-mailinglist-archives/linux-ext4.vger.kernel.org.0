Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD823C5F87
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhGLPqL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:46:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52436 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhGLPqK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:46:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A53E821A4A;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zf7waZOncrXNI+A+og1GfQDrBv+ysFpIJR+cPR1PMVI=;
        b=wvgoU1NsvWlwcp2b5nCUdTc0t/X68GJIhr/cbxoHN9A2AGkpl0iBIlEX3lEKAK8mRQHJsW
        8tLgf9P/7oNeawGNZg5exoFexkFPoYiiM2hGuPVNDfAdh7xcwiKmYVeMTtii3NVB61Fboa
        svrE+9iNbrG2WI/wxyzly6odOyuHUmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zf7waZOncrXNI+A+og1GfQDrBv+ysFpIJR+cPR1PMVI=;
        b=PfC7/qR+rVIdDvqkhEvbn2cnh0vQ3vzCKpyhrSDK6mGDIGNapuOlculWj52xLW3bE0XgIu
        sbWHjRvK8nKbCbDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 999FCA3B94;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 85E051F2AA9; Mon, 12 Jul 2021 17:43:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/9 v4] e2fsprogs: Support for orphan file feature
Date:   Mon, 12 Jul 2021 17:43:06 +0200
Message-Id: <20210712154315.9606-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; h=from:subject; bh=GkLySkSn3sR1tl2iUmWmp/jGqfLqsIwXsXMnfty8BcY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7GMKOlg65kS5oMVglyyvdi/9lhJLgcNPbkqLK82Q aqZgEC6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOxjCgAKCRCcnaoHP2RA2ft+B/ 9KLD2ij02Yc5mgBR9j9Wdo95ucEiv5vPkn6hIMzHfHZ+29u8LXEgD2SkUt/9AV8KwEDDf2eoDaRzbK O67rkUKvst/7LeK5qcQ8w/UD5D2Ofem14qjHzuAkEGTuxR/c9zKuq83bO/blY2toUHPyhhzAxUYeKB bz908yGMJVM4ut9Ffbik28VUZP7iGcaveqF+XcE/9/2ggv5cJHic9JPR1tfzXo/RNP13KDKpPlmfIn 9aHsJNs8u8gknHzvTKng6/Bn3nqGEl/94ciaQ3FvjIyidylNn3XSIlxa+JalNpfj2/Q/cw5FKbu6FK gt0/p8IRTcG7bUqS5ihpx250PLpaXo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello,

  This is the fourth version of support for orphan file feature in e2fsprogs.
The first patch removes feature bit for a feature which never happened and
probably isn't living anywhere (if it still lives I can allocate a different
bit...). Other two patches are fixes I've spotted while debugging this series.
I'm not aware of any outstanding issue with the series, xfstests pass fine with
it.

Changes since v3:
* updated to compute checksum also from physical block

Changes since v2:
* rebased onto current master branch
* fixed various bugs I've spotted during testing
* added support for debugfs, dumpe2fs, e2image
* changed code to use dynamically allocated inode number instead of fixed one

								Honza
