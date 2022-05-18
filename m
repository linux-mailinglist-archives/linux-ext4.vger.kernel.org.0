Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580D652C2F0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 21:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbiERSzH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241694AbiERSzB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 14:55:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD441F8C60
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 11:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0EC9B821AA
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 18:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADF0C385A5;
        Wed, 18 May 2022 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652900097;
        bh=J3dNW04lYjjvOpzQnYthNV5C2F15++WqsQgH3KLr2Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svFFFeBOUWogVA2WjX3w1zfeYB4IA+UuMQRmwW5dJP6Dw0IjrEa4a3+vd9e3MXCRR
         80j8IZ2/hgLUoUiwx5BQfCoRW22GYtyvL1Zimc2f07sGqXJX7kS2HSNdCpbgkQDC3S
         W9mwc4FcfJQaphpNAr/W2yxfk5DZJusdZfqWckgVO10x3qFUUXgSfB1pDrirc42rT9
         3PVkEcaGiVlY0cqoutm4wNcZ+CRQBoWZnICWr3oXLL+vVGEkNZLvaa8Ttn7BBArcX+
         tKxP8p1FExMnMJsjY0f4qeA77kd+S0cTvm78t995VEU/vC29qjTiZCyMZmrSl9n4v+
         xtS5olu7XYnAg==
Date:   Wed, 18 May 2022 11:54:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 2/8] f2fs: Simplify the handling of cached insensitive
 names
Message-ID: <YoVA/2sKDRAR5985@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-3-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 01:23:14PM -0400, Gabriel Krisman Bertazi wrote:
> Keeping it as qstr avoids the unnecessary conversion in f2fs_match
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
