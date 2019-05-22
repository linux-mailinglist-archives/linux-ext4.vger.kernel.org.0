Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256612600F
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfEVJD2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 05:03:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728542AbfEVJD2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 May 2019 05:03:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DED2B03E;
        Wed, 22 May 2019 09:03:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 665DE1E3C69; Wed, 22 May 2019 11:03:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3 v2] ext4: Fix issues in ext4 truncate handling
Date:   Wed, 22 May 2019 11:03:14 +0200
Message-Id: <20190522090317.28716-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Ira Weiny has reported that ext4_setattr() doesn't handle properly failure
of ext4_break_layouts(). When revieweing truncate handling code in
ext4_setattr() I've found some more issues. This series fixes them.

Changes since v1:
* added Reviewed-by and Tested-by tags
* removed unnecessary ext4_orpan_del() call

								Honza
