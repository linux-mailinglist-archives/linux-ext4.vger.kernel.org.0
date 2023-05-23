Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24AE70DDE9
	for <lists+linux-ext4@lfdr.de>; Tue, 23 May 2023 15:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjEWNuN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 23 May 2023 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjEWNuN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 09:50:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A371CA
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 06:50:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-182-swcgAvrnOkKU0tujxjiZ0g-1; Tue, 23 May 2023 14:50:03 +0100
X-MC-Unique: swcgAvrnOkKU0tujxjiZ0g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 May
 2023 14:50:01 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 23 May 2023 14:50:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Kara' <jack@suse.cz>, Ted Tso <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ext4: Fix possible corruption when moving a directory
 with RENAME_EXCHANGE
Thread-Topic: [PATCH] ext4: Fix possible corruption when moving a directory
 with RENAME_EXCHANGE
Thread-Index: AQHZjXiOnO+KSeLc6k+5S1Un0bHvlK9n30WA
Date:   Tue, 23 May 2023 13:50:01 +0000
Message-ID: <48d1f20b2fc1418080c96a1736f6249b@AcuMS.aculab.com>
References: <20230523131408.13470-1-jack@suse.cz>
In-Reply-To: <20230523131408.13470-1-jack@suse.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara
> Sent: 23 May 2023 14:14
> 
> Commit 0813299c586b ("ext4: Fix possible corruption when moving a
> directory") forgot that handling of RENAME_EXCHANGE renames needs the
> protection of inode lock when changing directory parents for moved
> directories. Add proper locking for that case as well.
> 
> CC: stable@vger.kernel.org
> Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a directory")
> Reported-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/namei.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 45b579805c95..b91abea1c781 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -4083,10 +4083,25 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (retval)
>  		return retval;
> 
> +	/*
> +	 * We need to protect against old.inode and new.inode directory getting
> +	 * converted from inline directory format into a normal one. The lock
> +	 * ordering does not matter here as old and new are guaranteed to be
> +	 * incomparable in the directory hierarchy.
> +	 */
> +	if (S_ISDIR(old.inode->i_mode))
> +		inode_lock(old.inode);
> +	if (S_ISDIR(new.inode->i_mode))
> +		inode_lock_nested(new.inode, I_MUTEX_NONDIR2);
> +

What happens if there is another concurrent rename from new.inode
to old.inode?
That will try to acquire the locks in the other order.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

