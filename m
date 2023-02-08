Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36FF68F82F
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Feb 2023 20:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjBHThp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Feb 2023 14:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjBHTho (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Feb 2023 14:37:44 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0891129E1C
        for <linux-ext4@vger.kernel.org>; Wed,  8 Feb 2023 11:37:42 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 318JbUVR012588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 14:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675885052; bh=WS8yi8V+z1lLpmoH+0uIKeV1wOV5nUwuLs7CM/oWWsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fWZexWOdUQPoK2iQ5J7DxyBlN1+HNKAgl/kjEZ6I64BzOGEO8heMMJHy9k+IVPxeS
         VRS2ZTx6lbpRHO272sSRLoNUoA78BxZ23iUK1GHZPzJ+7A62Xhd0+z2c9dK/KNGIyW
         wxnQJlRFs8jZ7axYmWilPLcI8Is54nrN+U+2OfPte5vD7GuyuRGDeQucE7Jb8SK4+z
         Zs1HF5K0VCG9C6Z+jfcGsYJhSkXmtTkqrKadfcsflc2zFPpDrgK73vh41bBcirG/VN
         iHmka7egx9sOAjDmK5YiOgi79HDBp8fNyWbilNlhm/dKfKbRuFWBO3jIcZ684GtSPD
         xj5fg03OZiv9w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 125F715C35A2; Wed,  8 Feb 2023 14:37:30 -0500 (EST)
Date:   Wed, 8 Feb 2023 14:37:30 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        abuehaze@amazon.com
Subject: Re: EXT4 IOPS degradation between 4.14 and 5.10
Message-ID: <Y+P5+jrsZOjqG+VT@mit.edu>
References: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
 <20230126093231.ujn6yaxhexwzizp5@quack3>
 <b948ed49-1bdf-b17e-d03a-7ec8dfdb1afc@amazon.com>
 <20230127121721.lerrb36nhj7gdiwm@quack3>
 <6a0fcca5-b869-ffb7-426b-b49a6782c1c0@amazon.com>
 <20230208140247.rt62xdtriopfdb4o@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208140247.rt62xdtriopfdb4o@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 08, 2023 at 03:02:47PM +0100, Jan Kara wrote:
> > I believe its the MySQL database though not so sure.
> 
> Well, in that case I think your MySQL DB is somewhat misconfigured. At
> least as far as we have been consulting MySQL / MariaDB developers
> regarding benchmarking, they suggested we should configure the database to
> use direct IO and increase DB internal buffers instead of relying on
> buffered IO and pagecache behavior. And if your fio job is representative
> of the IO load the DB really creates, I'd agree that that would be a saner
> and likely more performant configuration ;)

Could it possibly be Postgres?  I happen to know that Amazon RDS and
Google Cloud SQL support both MySQL and Postgres, and there are some
optimizations that some of us in the Cloud space have been pursuing
which are much easier because MySQL uses Direct I/O, but unfortunately
Postgres uses buffered I/O and doens't support DIO.  :-(

							- Ted
