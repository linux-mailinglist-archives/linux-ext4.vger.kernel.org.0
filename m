Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801CE3A984A
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhFPK7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35790 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhFPK7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 988C11FD6E;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GQIxr/VEW28OlBMCkhraBNg14hr6TB1xA5QgX7HlrI4=;
        b=rNzYsBHMMGKDYjNoxQBMjJ6CjQe9ngpctUAf8dHXYdlWZ74AKoylgn9QNrQG6OFgfbOuDe
        VXAew5BVzycfMRcO3ZlCUlMp6fmFcMKNB0L3owkXGZ1hIqkE0DeS8T8AgHbO7SKM010jru
        TXFR1LJl5OrBS6OrvUbmvs6qHIPVrj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GQIxr/VEW28OlBMCkhraBNg14hr6TB1xA5QgX7HlrI4=;
        b=xG9+dbSZ5m9xmpd7Ed3OaTDkjwdERARW8fRDdo3GCorgDNvcF7Me0+tFWRd5QXHYtplqRz
        6JlDnW+OnNgDUdBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 86510A3B98;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5912F1F2C88; Wed, 16 Jun 2021 12:57:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/9 v3] e2fsprogs: Support for orphan file feature
Date:   Wed, 16 Jun 2021 12:57:26 +0200
Message-Id: <20210616105735.5424-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello,

  reviving this series after 6 years. This is the third version of support for
orphan file feature in e2fsprogs. The first patch removes feature bit for a
feature which never happened and probably isn't living anywhere (if it still
lives I can allocate a different bit...). Other two patches are fixes I've
spotted while debugging this series. I'm not aware of any outstanding issue
with the series, xfstests pass fine with it.

Changes since v2:
* rebased onto current master branch
* fixed various bugs I've spotted during testing
* added support for debugfs, dumpe2fs, e2image
* changed code to use dynamically allocated inode number instead of fixed one

								Honza
