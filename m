Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D3355909
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Apr 2021 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhDFQSO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Apr 2021 12:18:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233688AbhDFQSN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Apr 2021 12:18:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E83BB256;
        Tue,  6 Apr 2021 16:18:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E5FA31F2B77; Tue,  6 Apr 2021 18:18:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] ext4: Annotate two harmless KCSAN data races
Date:   Tue,  6 Apr 2021 18:17:58 +0200
Message-Id: <20210406161605.2504-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

the two patches in this series annotate two known (and known to be harmless)
data races in ext4. In the first case, let's also add a comment explaining why
the race is harmless.

								Honza
