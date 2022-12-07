Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9B64598C
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 13:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiLGMAO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 07:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLGL74 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:59:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81927C
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:59:39 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 386EF21C9B;
        Wed,  7 Dec 2022 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670414378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kDqVW9q5urJG5aAqUFxY4uqhQsCoZ4OPl+3rTUQdrGM=;
        b=P4sfb04w+Y3XuGzlUyLbOI0iylvk68XZfBy3y8Bb+WT4XgNru0XzFC4WioidxmNEi/HDjM
        Zw5unFKlDbDZd82l4diHlwYcWYzPIJxY2RpuHm7HoQnqiwdrWN1reL8OiiXvTlxcVQQozw
        eSiUnZa/PV3d3oM752oCN+g6iCHQItU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670414378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kDqVW9q5urJG5aAqUFxY4uqhQsCoZ4OPl+3rTUQdrGM=;
        b=qVhQNLGf6DFKvotBbIXh0lZPRGUIJlfGu8Xrg6eav6PJYlq7dPpu4QfgBMRtz8VGswY6WI
        jzBbAgpT4zvcPVCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 295D1136B4;
        Wed,  7 Dec 2022 11:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id obybCSqAkGNsPQAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:59:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 524A5A0725; Wed,  7 Dec 2022 12:59:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Pengfei Xu <pengfei.xu@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] ext4: Fix unaccounted allocation when expanding inode space
Date:   Wed,  7 Dec 2022 12:59:26 +0100
Message-Id: <20221207115122.29033-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=158; i=jack@suse.cz; h=from:subject:message-id; bh=Hr7YfmI8yJIHViN1mzL38eQMYwBLNa2JsgT1XqdrWJ8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkIAdKj83xrjUrlz12l6J2OCQH5W7ZXqfrTHtkWxL xYasXS2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5CAHQAKCRCcnaoHP2RA2UdwB/ 0U+XzxgVbC0toucWDga1zALWCwOSi0XjsgWum2kUMLIDap3Q90zJ+WSa/bxpXXsAh9/jfc+lIN9H4v +kDotKF/6UiS5qu3fE6oCAEkuR1/VwsjSrncFkKvZFwdRk8JKMWenS7WnSet3vqyIHMV82On+NhFvm gEkhpF+jGydpuvQTwUJQxIqrL+VLs/truXwFkuzHSr8j28kHk8Qbkpxc9PzznEpekkbr5Tt8mz9ByE LXkA2J2C7LlKUiBNEhXFzlN7gmCqhUUjMBt6EoAb1KbkutDlS+P1AliFTQWWM5uotD2E/sEvRxkNnw tdT7LqM7/4kqtoMvkRkl9PHdYRX9ee
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

these patches fix the warning (and resulting block allocation not accounted
into quota usage) when expanding space in the inode.

								Honza
