Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD26E42571E
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbhJGPzg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 11:55:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48384 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhJGPzg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 11:55:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81F181FE5D;
        Thu,  7 Oct 2021 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633622021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QTQyKU7phCXuG4dVg+JuY6LFQuGctf5hx/YITl0v7Yg=;
        b=AqSIFoToTqgu34P4EStdXufxFJue3ZooJewo6ANxowIAJcjRZGmPS29odXgYCx428P2nEn
        tYocOgSEHhapIdt/bx9qJTde8OGwRIk1XWBhs9wooBlkwxOfvb6BJ3OFL643/pbeSYY6a4
        e6WF56paMGWv2p/i/YuSH4KiPoWUvz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633622021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QTQyKU7phCXuG4dVg+JuY6LFQuGctf5hx/YITl0v7Yg=;
        b=Wfe1b32FU/4/OQpOc0PNruOg0hwjQt/I0NISD+3z5uOE1SBRRmOja5SrKctzjjzah2xvSk
        tPg6kMBjyWcwSRDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 763B6A3B87;
        Thu,  7 Oct 2021 15:53:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 33FF11F2C96; Thu,  7 Oct 2021 17:53:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>
Subject: [PATCH 0/2] ext4: Quota enabling error handling fixes
Date:   Thu,  7 Oct 2021 17:53:34 +0200
Message-Id: <20211007155336.12493-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hello,

when enabling of quotas fails in the middle, we could be leaving quota
subsystem in unexpected state or free inodes with locking classes set.
Make sure to do proper cleanup in case quota setup fails.

								Honza

