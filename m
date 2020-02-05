Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63565152957
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 11:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgBEKjZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Feb 2020 05:39:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:43260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgBEKjZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Feb 2020 05:39:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCAC7AE8A;
        Wed,  5 Feb 2020 10:39:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C59BE1E0A51; Wed,  5 Feb 2020 11:01:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] e2fsprogs: Better handling of indexed directories
Date:   Wed,  5 Feb 2020 11:01:35 +0100
Message-Id: <20200205100138.30053-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Currently, libext2fs does not implement adding entry into htree directory. It
just bluntly clears EXT2_INDEX_FL and then treats the directory as non-indexed.
This breaks when metadata checksums are enabled and although ext2fs_link()
tries to fixup the directory, it doesn't always fixup all the checksums and
I have some doubts about practicality of just discarding htree information for
really large directories. This patch series implements full support for adding
entry into htree directory and some tests to test the functionality. The
first patch in the series is somewhat unrelated, it just clarifies handling
of overflown directory i_nlink handling in e2fsck which confused me initially
when analyzing the issue.

								Honza
