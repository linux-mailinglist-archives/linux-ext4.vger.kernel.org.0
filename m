Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F326BBCF2
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 20:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCOTIJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 15:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCOTII (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 15:08:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020EF2DE5C
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 12:08:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32FJ7raZ017918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 15:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678907275; bh=SipF4mXr0SWwKv19CTpPSkrDCfup+1l9M2ULmlF7psE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RZXSv2q5hkkz+kTvm5706zGU0f1l0md+vE6VEFqzZuX0OHDHLPQ9PUpF2NUudM91+
         TMlYT95o3Mu9Dvs/ih0RY/84uJvvbz0xUpA2ivWmKHO2phAfWpZsMzGHtb9dML9PpD
         aUvD1Yjv0xnSDsYiId1wMCn0SOU0MQbYpl7VkndYqPqbVPY25uXwnpkOqFkCHHqyD6
         OerKuZ1wdNcBQYBWuFsYigPaQfeMClEIzGr+QIy8xo17RTQGFpcjPLBM5pag0Zxlkm
         hLdgQaDH6ASPfcd8hN3TwRDNbA1H3F7QQP69ykC1Skh+qG0WIPN7+xrIjkEf7zVgNi
         sDTh7JJ2J7M1Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2E18F15C5830; Wed, 15 Mar 2023 15:07:53 -0400 (EDT)
Date:   Wed, 15 Mar 2023 15:07:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] ext4/super: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
Message-ID: <20230315190753.GC3024297@mit.edu>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315181902.4177819-7-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 15, 2023 at 06:18:54PM +0000, Joel Fernandes (Google) wrote:
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> The kfree_rcu() and kvfree_rcu() macros' single-argument forms are
> deprecated.  Therefore switch to the new kfree_rcu_mightsleep() and
> kvfree_rcu_mightsleep() variants. The goal is to avoid accidental use
> of the single-argument forms, which can introduce functionality bugs in
> atomic contexts and latency bugs in non-atomic contexts.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

