Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF27E6F09CD
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Apr 2023 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbjD0QZS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Apr 2023 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbjD0QZC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 12:25:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407092;
        Thu, 27 Apr 2023 09:25:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC0A421BF2;
        Thu, 27 Apr 2023 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682612699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=q7TAZ0q4h7Wv9H0RCQhUyP+h1ay8o9EaK4u28oaZeQ0=;
        b=oNSTZUlZ/Bfmms23RAIls+WqCin+tzUUbtYXZ7nHS4MFKPMUsFQY9X1qnzRMpLReSl+HzB
        AVoMT28rVzZZr+f8/Adyf7WmHT6WQrAyrRnWxG2cxeL9CZ1lpyD/eH3cc6D/Wr8SkuNX9x
        Wmyoa/YbgyMI/jwuO5zE5fw35bw5QxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682612699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=q7TAZ0q4h7Wv9H0RCQhUyP+h1ay8o9EaK4u28oaZeQ0=;
        b=+nvjVt0j6fdUD6PeEaHt5dZBScQlgaeafhSYNQvVrleltQ1WKnWqjwYxrVjxwf99iLfrLi
        RE23KCM4HN34QhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEE65138F9;
        Thu, 27 Apr 2023 16:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yuqnKtuhSmRyWAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 27 Apr 2023 16:24:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 23DE3A0729; Thu, 27 Apr 2023 18:24:59 +0200 (CEST)
Date:   Thu, 27 Apr 2023 18:24:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     stable@vger.kernel.org
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Pick commit 2729cfdcfa ("ext4: use ext4_journal_start/stop for fast
 commit transactions")
Message-ID: <20230427162459.qb3tnh3be6ofibzz@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

recently I've debugged a deadlock issue in ext4 fast commit feature in our
openSUSE Leap kernel. Checking with upstream I've found out the issue was
accidentally fixed by commit 2729cfdcfa1c ("ext4: use
ext4_journal_start/stop for fast commit transactions"). Can you please pick
up this commit into the stable tree? The problem has been there since fast
commit began to exist (in 5.10-rc1) so 5.10 and 5.15 stable trees need the
fix. Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
