Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9381A0138
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 00:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDFWpk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 18:45:40 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57777 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDFWpk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 18:45:40 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 246B9C0003
        for <linux-ext4@vger.kernel.org>; Mon,  6 Apr 2020 22:45:37 +0000 (UTC)
Date:   Mon, 6 Apr 2020 15:45:34 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-ext4@vger.kernel.org
Subject: Use case for EXT4_INODE_HUGE_FILE / EXT4_HUGE_FILE_FL?
Message-ID: <20200406224534.GA668050@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Under what circumstances can an inode ever end up with EXT4_HUGE_FILE_FL
set? (Other than in an artificially constructed filesystem.)

As far as I can tell, extents don't allow a file to get bigger than
2**32 filesystem blocks (because they store block offsets in an le32),
which with the maximum filesystem block size of 65536 would be 2**48
bytes.

That's lower than the file size limit that EXT4_HUGE_FILE_FL seems to
exist to surpass; even without EXT4_HUGE_FILE_FL, the 48-bit "block"
count in the inode would allow a file to have 2**48 512-byte "blocks" in
it, or 2**57 bytes.

Was EXT4_HUGE_FILE_FL just added for future extensibility, in case a
future file storage mechanism allows storing files bigger than 2**32
blocks?

How extensively has it been tested?

(Related: are there any plans or discussions regarding a future extent
format? Not necessarily just for that reason, but there are other limits
in the existing extent format, such as the limit of 32768 contiguous
blocks in one extent.)

Thanks,
Josh Triplett
