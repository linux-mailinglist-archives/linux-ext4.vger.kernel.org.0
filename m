Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB13220DE1
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jul 2020 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgGONS2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jul 2020 09:18:28 -0400
Received: from [195.135.220.15] ([195.135.220.15]:45956 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731596AbgGONS2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Jul 2020 09:18:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60D1CB707;
        Wed, 15 Jul 2020 13:18:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E282A1E12C9; Wed, 15 Jul 2020 15:18:26 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] ext4: Check journal inode extents more carefully
Date:   Wed, 15 Jul 2020 15:18:08 +0200
Message-Id: <20200715131812.7243-1-jack@suse.cz>
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

								Honza
