Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AA3F34C8
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhHTTro (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 15:47:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhHTTrn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 15:47:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5994B2016C;
        Fri, 20 Aug 2021 19:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629488824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aRSM7XW60W4MGqEBwZMjSBEpX9sHE3ad6XQaEnmznmQ=;
        b=UFmlhNEVLOIUiAUr6uWtrV0Mqrn2T37wXxNl0B17a4ef72Wqf2jESAc1wJK8plZ+wtuJ/r
        TAYzEJrzrsFw6kjQsN/wsjGWXaIZx46hDZcf3/VkCIWEN3Nbp7xwcifP1BqI0PizKPw8nl
        Pg8UdxQMAwwry4xxLYa7AUbBdAV9mAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629488824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aRSM7XW60W4MGqEBwZMjSBEpX9sHE3ad6XQaEnmznmQ=;
        b=EObgRe3bmvG7VlOqimtWKWCFxuq9wkpH6wNckLRBLOSOuX16aovJVkLNDdWQdcepQEMgdJ
        edCIh2kS7w4yQEAQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 4DC23A3B88;
        Fri, 20 Aug 2021 19:47:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2E6251E0BFE; Fri, 20 Aug 2021 21:47:01 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] Quota fixes for e2fsprogs
Date:   Fri, 20 Aug 2021 21:46:54 +0200
Message-Id: <20210820194656.27799-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=426; h=from:subject; bh=lBjSTkkQ4d2Ts/QV4dNrMrvLW6zVuJjuEtBAZQs1uGw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhIAaogYoU61rx5P22AAbuIGuAerBUJzf1VIQgumli d2m36V6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSAGqAAKCRCcnaoHP2RA2W06B/ 9l1AUouvkcFqPZ5aoBQrqg4zxiECXa/n835Ok144N/FF+xLc9WMYG/2iCB7mAlN99M+BuOM2tCa5Yw pG3OR4ct5JdG7tpJ/2v1QwMawBPYvA83Cj7DhQwuxQ0qZDpMc9wC04OJh6jGoorRwmAFu2SNx9742I ubGDIPlg9Hx8q+PUBewPtxPIP/lThuenao3765rmh+UoHKWrQNz5oSrV+aUkL4qozTEf9SQT+annnP XjRoFzzWVlqmwRNDVAPRBYhr3MRUrU0VFwBil2Lja8zUGjkuW09ANbsHM7B6iO+yQQWX9uPruu/0hh n89h8zA5Bv7LpeZIArtD9T4qC9rOwx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I've been testing how transition from old-style quota files to ext4 quota
feature works and I've found two serious bugs which make the transation
problematic. First, e2fsprogs do not support commonly used version 0 quota
format (which has 32-bit inode and block limit counters) and second, the
transfer of quota information from old quota files is broken. This series
addresses both problems.

								Honza
