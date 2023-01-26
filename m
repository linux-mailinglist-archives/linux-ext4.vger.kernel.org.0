Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50E67C3B2
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jan 2023 04:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjAZDvM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Jan 2023 22:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZDvL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Jan 2023 22:51:11 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51D14900B
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jan 2023 19:51:06 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30Q3ovDX017570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674705059; bh=0rmKRnDANtTXsSPM/lH1dmHUlp/7VIjW+HXesrKdRBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qUjtjliCDgA1iHgCeOUMlY/0GcicNrqAV5jkaQpzxh4QF5njw6qtCH/3rswS94f9a
         fUM8RTFKAT7E8BRu0TYbuKJPdF4y1IMbeHDiiQdFs7TQV/CBg9EcaBWNE4LAd7X1cq
         du352+Rt+Q1JrB/ShbGKurZfRCqhtr9uTg7HUpt4gH7EOo8SKqwzz6YEWDpnUWIGnH
         VKMN0MMXWAVYJosfOPJt5TsMoKnNHziMiVRY9YbLpZv3BOJ4d35LRKmOoLzgpBvOMM
         cxPL40yCknYQnioKmyITXMUPAJZSv8lf+/n1rq4Yuj0pJIFovCYnpi8cOr5r3UHKgm
         94ozkrME/h+0Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6D15915C3587; Wed, 25 Jan 2023 22:50:57 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        paul kairis <kairis@gmail.com>
Subject: Re: [PATCH] e2scrub_all: fix typo in manpage
Date:   Wed, 25 Jan 2023 22:50:54 -0500
Message-Id: <167470504131.8995.15434028394235231519.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <Y37TU3KjcTk1B4TU@magnolia>
References: <Y37TU3KjcTk1B4TU@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 23 Nov 2022 18:13:39 -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Fix this reported typo.
> 
> 

Applied, thanks!

[1/1] e2scrub_all: fix typo in manpage
      commit: 13d69f3596ad49633be586bb0594452ccd2301ce

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
