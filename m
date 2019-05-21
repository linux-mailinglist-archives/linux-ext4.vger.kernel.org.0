Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FEA24930
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfEUHoH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 May 2019 03:44:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfEUHoH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 May 2019 03:44:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE464AD47;
        Tue, 21 May 2019 07:44:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C9D8B1E3C75; Tue, 21 May 2019 09:44:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] ext4: Fix issues in ext4 truncate handling
Date:   Tue, 21 May 2019 09:43:55 +0200
Message-Id: <20190521074358.17186-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Ira Weiny has reported that ext4_setattr() doesn't handle properly failure
of ext4_break_layouts(). When revieweing truncate handling code in
ext4_setattr() I've found some more issues. This series fixes them.

								Honza
