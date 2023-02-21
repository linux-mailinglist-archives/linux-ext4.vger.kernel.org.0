Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719AA69E4B4
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 17:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjBUQd1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 11:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBUQd0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 11:33:26 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD59A1206C
        for <linux-ext4@vger.kernel.org>; Tue, 21 Feb 2023 08:33:25 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31LGXF2N026137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676997198; bh=5sMaIVZHI3jdW3A9kgLBjlYpSMtuQJn4n/N/g9XfGys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NqZQjjwBidzTkaVeNaIAemY9bN09H9bj97S4yQqWIEJFBpDT8wXR90lm79tKUmP2v
         lLPgBllEQnuQOlK4a6r+1UdZ3kgj/sfxkkaQUx0oQnFAaIugCAxImi3eJnZrqsJnPw
         LaUKKFXEo9EkBb8JGyYuhQE/+lGScAd3k4mphzo5PJyDt5GqzbyNkL+QAY5w9NmJyu
         CjnAW/N7PmTF10GozqctjzHhSsjKOOqizUyfCdcQ1dgP6UxUrhyvav58gRLP164aBE
         4wdhQVmWc0k/v8EtY+PBoYVHOTIDMoI7fd//KfAi5x6bOfi+wsVtN1RU03B7EjoPKK
         ggiwAyhmPJ7bA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8DB8A15C35A1; Tue, 21 Feb 2023 11:33:15 -0500 (EST)
Date:   Tue, 21 Feb 2023 11:33:15 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ext4: modify the group desc size to 64
Message-ID: <Y/TyS9wkzMsr0j4Y@mit.edu>
References: <20230220110637.42678-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220110637.42678-1-bo.wu@vivo.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 20, 2023 at 07:06:37PM +0800, Wu Bo wrote:
> Since the default ext4 group desc size is 64 now and the size mentioned
> in this doc is 64 too. Change it to 64.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Could you please a parenthetical comment: "(assuming that the 64-bit
feature is enbled)"?

Thanks!

					- Ted
