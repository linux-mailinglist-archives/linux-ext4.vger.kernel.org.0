Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA877A77C0
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Sep 2023 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjITJku (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Sep 2023 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjITJkt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Sep 2023 05:40:49 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FD4AB
        for <linux-ext4@vger.kernel.org>; Wed, 20 Sep 2023 02:40:42 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <othacehe@gnu.org>)
        id 1qithH-0006sd-0P; Wed, 20 Sep 2023 05:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:In-Reply-To:Date:References:Subject:To:
        From; bh=8bvOK6TrYoINVaTISxNu0Rj6dnhPxNQg4x0nmGDRm0E=; b=PSKqvwsXPHZ/Metesd9c
        3RSqyjvGqZ0QI/J1FUUQ0Ec1b0RV67lXNyof44q4hyyZuSCeGDbuVKHPAHKy+6VO0C7j5IfDRaKgg
        /KdP2nJ16YE1PCeq6A1nrk9nwtbVrCCM4JayumoixBXawoMNnJN9XnM0XQJrVUHTrjBA/eBbP1J1/
        bKHqW3d4sIdZGfcRudT/UmTD6L7x1PnlVz5cBoEB7uXPM9jHJ1CKOzafj/w2p0YJkv78GR70H/QyP
        7GGNvEGLjBuzxBWos49gYa19tueBenwHneE3o8RPgk0OgT31i32p2dHZAXAYgmik2a8NgzrYnHzhi
        jat5iAku9vvJng==;
From:   Mathieu Othacehe <othacehe@gnu.org>
To:     Marcus Hoffmann <marcus.hoffmann@othermo.de>
Cc:     tytso@mit.edu, famzah@icdsoft.com, gregkh@linuxfoundation.org,
        jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
References: <20230315185711.GB3024297@mit.edu>
        <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de>
Date:   Wed, 20 Sep 2023 11:40:24 +0200
In-Reply-To: <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de> (Marcus
        Hoffmann's message of "Thu, 11 May 2023 11:21:27 +0200")
Message-ID: <87r0mt41yv.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hello,

I also encountered that specific issue while migrating from 4.14 to 5.15
with data=journal. The proposed patch fixes the issue for me. The 6.1
branch seems to be affected as well. Would it be an option to have that
patch applied to stable branches?

Thanks,

Mathieu
