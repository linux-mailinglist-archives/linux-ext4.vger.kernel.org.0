Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA71D73D0
	for <lists+linux-ext4@lfdr.de>; Mon, 18 May 2020 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgERJVX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 May 2020 05:21:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgERJVX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 May 2020 05:21:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 266EAAF57;
        Mon, 18 May 2020 09:21:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C3A9F1E126D; Mon, 18 May 2020 11:21:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] jbd2: Fix leaked transaction credits
Date:   Mon, 18 May 2020 11:21:18 +0200
Message-Id: <20200518092120.10322-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

after debugging more the reason why fsmark run is slower in dioread_nolock
mode (which became the default in 5.6), I've found jbd2 actually leaks
reserved credits if we start a transaction with reserved handle and then don't
use it. The first patch in the series is a small (and independent) cleanup in
the area, the second patch fixes the leak.

Then there was another revelation for me that in this workload ext4 actually
starts lots of reserved transaction handles that are unused. This is due to the
way how ext4 writepages code works - it starts a transaction, then inspects
page cache and writes one extent if found. Then starts again a transaction and
checks whether there's more to write. So for single extent files we always
start transaction twice, second time only to find there's nothing more to
write. In case all blocks are already allocated, we wouldn't even have to start
transaction at all.  This probably also deserves to be fixed but a simple fix I
made seems to break page writeback so I need to dig more into it and I want to
push out the obvious jbd2 fix early.

								Honza
