Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920C63F7B7
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 19:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLASqJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 13:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiLASqI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 13:46:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F65B43E5;
        Thu,  1 Dec 2022 10:46:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A896AB81FB7;
        Thu,  1 Dec 2022 18:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297A3C433C1;
        Thu,  1 Dec 2022 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669920365;
        bh=V7zopiTxJ/ldtGNUpiSTzYid/llltJsO8abDlgveqgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJplEwwv7ry5ArZ72Zlb2bno9TBsRkx7bfOHaYwsSeuWQnm+/OYKUX18jYzDkAsYK
         +ScgFICGVMYKq+196MAiYYHiGsaHtr73bcgeGWBXD68N6jbIw7pXWoHPFRNLO91I8v
         m8AA0vkNFl6hYEp1h94lxUEebBWBK0cyVf2cNkqWeft1SgGxIQrQHay5hIE2CSmqDB
         gWx6jiRbGaUBoYNPMQgUk5nDLmdJ0LlmnpCYWzbGZKeU8BM6gsDlHkoULX92k/ywiF
         p2BLma7cZY8/HcdeefES8jdt3GWSpqGAayVqgclAMkFL8IrCjysa8scJr7pgolSirr
         s+wFuW/zQFr8w==
Date:   Thu, 1 Dec 2022 10:46:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Haichi Wang <wanghaichi@tju.edu.cn>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: FOUND BUG WITH TITLE: <kernel BUG in ext4_getblk>
Message-ID: <Y4j2a16VPEqZbQz/@sol.localdomain>
References: <AOsAKwAOFVqmSoeI4YmdXKoQ.1.1669897562230.Hmail.3014218099@tju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AOsAKwAOFVqmSoeI4YmdXKoQ.1.1669897562230.Hmail.3014218099@tju.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 01, 2022 at 08:26:02PM +0800, Haichi Wang wrote:
> Kernel Version: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b3cc(v5.15-rc6)

Please test the latest kernel version.

- Eric
