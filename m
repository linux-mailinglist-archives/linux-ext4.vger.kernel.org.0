Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C736B581ABF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 22:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiGZUK3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jul 2022 16:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiGZUK2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Jul 2022 16:10:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE331DEB
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 13:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBE67B80D66
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 20:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743F5C433C1;
        Tue, 26 Jul 2022 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658866225;
        bh=ZrA09ISaRESz72+2HUqUVJP4XR1T/vN52Zf75VOF5AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDFN4UJRuAaRb/OSG+NDGCMdXTeZZ86jwj+8xCSLZN2QrQCvAEqKQ6xHHUv/mYcZK
         CtmaPwv6N0Pc+UQPBt9aJ90ZhG1jZzUtsmIt0FE9QHnprGKCPGBJTJnPVFZOhtnHc/
         cY601ew5Iqoi325sGNIEwAPa2gN9T8vkBGGjgG4Xv1J8Q3vjF2nOUGCV19soGlO+SS
         ohe3bStiO28z+WWlebtLmEkxg2pMBrufvH4IEYpPelfkqZotP3AMCC+MQOfSpgeQEW
         UngKsKCkjvhVPEwuETF+e9e1gPLN+3K1zf/yEfttEapa+mcejKngW077aTiSYx1BPD
         xyxbiyOlb8OBQ==
Date:   Tue, 26 Jul 2022 13:10:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     bugzilla-daemon@kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <YuBKMLw6dpERM95F@magnolia>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216283-13602@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If you are going to run some scripted tool to randomly
corrupt the filesystem to find failures, then you have an
ethical and moral responsibility to do some of the work to
narrow down and identify the cause of the failure, not just
throw them at someone to do all the work.

--D
