Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA66A6B78
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 12:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCALMy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 06:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCALMu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 06:12:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A718B2B
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 03:12:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AB5C219F8;
        Wed,  1 Mar 2023 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677669159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f3oLJn9rUd/JMMv4wpqI0iYbNAi9cxswQy4aXX8S6+U=;
        b=ctSKcjMtDPq25V6HZXWsDl2D8BlBuDjp9Qh/V/6vJH1ic5LdaqOon4PuW6j1N1+gzeBjpc
        UVp0EiIlSUw4vfO5DmlDlebNYUsxe3FGUKyaxXBlhYgvHqs7BeQdcokZAw556x+qWxZjGJ
        MOVweg8BTgrZuZljoxO0QHpUVPh8aTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677669159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f3oLJn9rUd/JMMv4wpqI0iYbNAi9cxswQy4aXX8S6+U=;
        b=00eOLr5D+Z0FOhO3cuzn8LefQBHedCXPYCSwjVpUqHb4zSWy2I97CCk+fMJZYwAm2RFzRn
        ImUk+NhCPGWelXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4010813A3E;
        Wed,  1 Mar 2023 11:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nJqkDycz/2MARQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 11:12:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BF56CA06E5; Wed,  1 Mar 2023 12:12:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] ext2: Refuse filesystems with invalid block size
Date:   Wed,  1 Mar 2023 12:12:29 +0100
Message-Id: <20230301111026.15102-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=214; i=jack@suse.cz; h=from:subject:message-id; bh=JLlJcJFwr18BqfL4gkWAqM9dKyVUV0ZmyD6E/VeyqDo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj/zMH37ERUl5QQxNNTmxMtuDor4w+5ySU7D9M+eMJ ahh6uyaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY/8zBwAKCRCcnaoHP2RA2dSyCA Chlv1+3gGN0uoASC12pquYm3UcrfYulSuwX7qX/6LS6Am7OkQI1f0JaQNipq8DpINbaL2eDAG0861O npilk5uHg6d/R+qAE7BACecKA8gMfB19obe1XlnDBOCQVJhVhofZnD7/496GV+x2ew5Bu3h3eSwV/F hMac20TMHCHshHynOvjQx+MHNTgVvzzt5couvuF51eJKu1CxWW0n8oRhw20lJidkkxTaoY2J+m52ja Qyi4Yc0su4rH6NQ5DObI/XIrhWXDhebEps1hRTT+iBaKe4qqd8a5tgd0DLsYmRaek3ePYcdz7Q8HQX MKcIs7qMrzgeXE1vfnbRy/OgvrNiZp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

these two patches make sure to validate log of filesystem block size stored in
the superblock before it is used to avoid undefined shifts. I plan to merge
the patches through my tree.

								Honza
