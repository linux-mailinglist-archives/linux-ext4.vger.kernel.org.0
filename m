Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48925717A5
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jul 2022 12:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiGLKyl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGLKyk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 06:54:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FAAE3B7
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 03:54:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 610A022951;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657623277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=47mCf1p0jFtyNhB9L1dY1I2vlfCFmKIHILl8TJQpmAc=;
        b=UYLL6/Btz6FQcqH80rJTnIuIscXqgPY2DhzhrgDh1f+0E4SAdVLXQQjidJsRlXkNUYKilQ
        YPLwaaSiHoUQcbUDTro285c1WkSOTALCnvPpTW/WWRIIRGOjhTYbxfHRwRroGTwBOosI07
        wUULkNJK/hoKB/xV9vcEi4nY7Gppclk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657623277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=47mCf1p0jFtyNhB9L1dY1I2vlfCFmKIHILl8TJQpmAc=;
        b=MHUR7CushOGinc1rIsaRqDIcQqbKDPaVT8hd+D658kLPTXMW2fpeKM/J/EbCsFf8qhYDks
        XWmCAC7fd9QmpeDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4FC732C141;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E879CA063F; Tue, 12 Jul 2022 12:54:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/10 v3] ext4: Fix possible fs corruption due to xattr races
Date:   Tue, 12 Jul 2022 12:54:19 +0200
Message-Id: <20220712104519.29887-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; h=from:subject:message-id; bh=7qgtjg8mh3DaeVhdkGup2h1tvc3/K0+fzP+HCtmx6wY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBizVLMzUOGWONVqdU2Cb80Kx9cXnnf81XBwi65PgTg W9KtgVyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYs1SzAAKCRCcnaoHP2RA2buOB/ 90NmSruz+2ERNSgGnItfpGpyKIb3Zyu5n3oTKmKc//GMR1cQE0c1qNBO8bNfDGz5S7BoB3xJljyVo1 GetdgALai3KB7MUZvuI3stp3ME0TF4k93AYtE0y23g0+fl0GhgdH5cQFgVc0lcWS++0OBsu8ZZr7OE RzpB03unf3h2uOhAUxlbxmA+TfbIJaEvUjc5jNE4jtxKJtuPHtQx5osFe/HQ4C5BNkAyy3gV501zyZ UCKLpip6vd9+sCK+9wn4XskiHFuzM5iB6oO8J2EDDZebMrvHwN1TbrhDa4mV/fW9HcbZGAONRUkhqu LPfZwcowTAyVVITNDNW+4gzpthibUU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

I've noticed this series didn't get merged yet. I was waiting for more review
feedback from Ritesh but somehow that didn't happen. So this is the third
submission of the series fixing the races of ext4 xattr block reuse with the
few changes that have accumulated since v2. Ted, do you think you can add this
series to your tree so that we can merge it during the merge window? Thanks!

Changes since v1:
* Reworked the series to fix all corner cases and make API less errorprone.

Changes since v2:
* Renamed mb_cache_entry_try_delete() to mb_cache_entry_delete_and_get()
* Added Tested-by tag from Ritesh

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20220606142215.17962-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20220614124146.21594-1-jack@suse.cz # v2
