Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B7079EC0F
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjIMPFL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Sep 2023 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjIMPFK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Sep 2023 11:05:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8EBD
        for <linux-ext4@vger.kernel.org>; Wed, 13 Sep 2023 08:05:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B4A7218E4;
        Wed, 13 Sep 2023 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694617505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=29oIwgxtwdAJfLxOVgUhRofiHq3btV+Q2ysjg2bOJWs=;
        b=Fg1TsMPMWAASzjZNtp8/19NF1hJyrSC3IZJcNB/UovM+X1U0sUxO7rURJNG7ZDNIpcZd8m
        19GFhZ8EyNBa2bsTfp5fsMPDGKMKlaaXiWRVK6RDyo3hy9iMIVa7+h2Ji+W2L34enPuv5o
        5/OCvqr2cS8dVwJqN/U8nf8IT7urzOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694617505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=29oIwgxtwdAJfLxOVgUhRofiHq3btV+Q2ysjg2bOJWs=;
        b=I8mC4RlvnpiAXnBHCsCV+7R1g+O0WKh3SeuMLzjAXt25ftv1MZdqavH60DLRlytYpFNYNX
        4oOA/5tI8CTj9NBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D3A113440;
        Wed, 13 Sep 2023 15:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id axW4FqHPAWUHdQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 13 Sep 2023 15:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D9C76A07C2; Wed, 13 Sep 2023 17:05:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, todd.e.brandt@intel.com,
        lenb@kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] ext4: Do not let fstrim block suspend
Date:   Wed, 13 Sep 2023 17:04:53 +0200
Message-Id: <20230913145649.3595-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=450; i=jack@suse.cz; h=from:subject:message-id; bh=g4tHakMVK9JYVNO0sO0v6LlgGxzGdr3NzT4Yn5es0VI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlAc+PrZr7nInGgLrUdLW2/RjsHXpY39Oib30gyE3T /6QvwvyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZQHPjwAKCRCcnaoHP2RA2VgqB/ 4ox2jYVF8GaiB5GcRaV0JWImtsvKT1rPUvwlbq+f7e7gJiznNuHUWj3n4hA3DHrGSGrWsonPKta47P a+PxlZPAMc87FytU8k8R/Qro2o5TQjxUDl6s5DCYNrMAtgpNZuCQFsg8xYpMkj2iP4FMqCCu08gOnU se322Tjf02oF67Pbf7zRsneYJh4MBuk0fTzY2oWuj5yc7mYXfsK5L6NZvlHQCz97LhPnQ66sS5sOCu 5qIWwis9sRU0hdv32PurKkHOKp3rry40WCwS1qQYMXZKzhqJpF23ZmMo6fs7h7WD3FSOUGyflXVdUx +gCAVrBLVLEEEjYEbtkTJ/Z+UOYXPl
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

these two patches fix a long standing issue that long running fstrim request
can block a system suspend as reported by Len Brown in [1]. The solution is
quite simple - just report whatever we have trimmed upto now since discard
is an advisory call anyway. What makes things a bit more complex is handling
of group's TRIMMED bit - we deal with that in patch 1.

								Honza

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216322
