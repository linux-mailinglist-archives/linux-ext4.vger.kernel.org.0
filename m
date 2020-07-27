Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671DF22EB5F
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 13:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgG0Lob (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 07:44:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgG0Lob (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 07:44:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0C67B68F;
        Mon, 27 Jul 2020 11:44:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4AE9A1E12C5; Mon, 27 Jul 2020 13:44:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/6 v2] ext4: Check journal inode extents more carefully
Date:   Mon, 27 Jul 2020 13:44:23 +0200
Message-Id: <20200727114429.1478-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

This series changes ext4 to properly check extent tree blocks of journal inode.
Omitting these (which is a limitation of block validity checks) leads to crash
in ext4_cache_extents() in case the extent tree of the journal inode is
suitably corrupted. 

Changes since v1:
* Added Reviewed-by tags from Lukas
* Fixed two more unrelated minor bugs in block validity testing spotted by
  Lukas

								Honza
