Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8716610EDA7
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Dec 2019 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfLBRCQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Dec 2019 12:02:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:53812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727459AbfLBRCQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 2 Dec 2019 12:02:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F161BD20;
        Mon,  2 Dec 2019 17:02:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 445A61E0B7B; Mon,  2 Dec 2019 18:02:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v2] ext4: Handle directories with holes better
Date:   Mon,  2 Dec 2019 18:02:11 +0100
Message-Id: <20191202170213.4761-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

here is a fixed up version of ext4 patch to fix ext4_empty_dir() for
directories with holes. There's also another patch that tightens checks in
ext4_check_dir_entry() so that directory iteration code cannot read data
beyond end of the buffer.

								Honza
