Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C9486350
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 11:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiAFK6y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jan 2022 05:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238102AbiAFK6x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jan 2022 05:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641466733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIytc1jgI2/NZ+AETmDB2hLnS+2e0hrq7D/0F+5lakk=;
        b=X7NSlQ1nfEiwNfXQCWv7i35DYC3/CI7yyVTobPgIocZixiTOX8hU0VqQIiX4pkBoMO8VFa
        RfuNF6xhyZCtrSaHosWD7kzpIIxSAuH/A8DRYboKkPmwezk7QcmNWOaqT9jfSgiKEPwPIx
        xs4f2TH9Jidv15bd/wgU+WE2LAv2k1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-4ZBzAYbiNHuldmZTFD74AA-1; Thu, 06 Jan 2022 05:58:51 -0500
X-MC-Unique: 4ZBzAYbiNHuldmZTFD74AA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC8BE18C8C00;
        Thu,  6 Jan 2022 10:58:49 +0000 (UTC)
Received: from work (unknown [10.40.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A1A752AC;
        Thu,  6 Jan 2022 10:58:47 +0000 (UTC)
Date:   Thu, 6 Jan 2022 11:58:43 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     cgel.zte@gmail.com, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH linux] ext4: Delete useless ret assignment
Message-ID: <20220106105843.comh4jk3krxppgbp@work>
References: <20211230062905.586150-1-luo.penghao@zte.com.cn>
 <YdZzt0LF/ajTGNXo@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdZzt0LF/ajTGNXo@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 05, 2022 at 11:44:39PM -0500, Theodore Ts'o wrote:
> On Thu, Dec 30, 2021 at 06:29:05AM +0000, cgel.zte@gmail.com wrote:
> > From: luo penghao <luo.penghao@zte.com.cn>
> > 
> > The assignments in these two places will be overwritten by new
> > assignments later, so they should be deleted.
> > 
> > The clang_analyzer complains as follows:
> > 
> > fs/ext4/fast_commit.c
> > 
> > Value stored to 'ret' is never read
> 
> I suspect the right answer here is that we *should* be checking the
> return value, and reflecting the error up to caller, if appropriate.
> 
> Harshad, what do you think?

Indeed we absolutely *must* be checking the return value and bail out
otherwise we risk overwriting kernel memory among other possible
problems.

See ext4_fc_record_modified_inode() where we increment
fc_modified_inodes_size before the actual reallocation which in case of
allocation failure will leave us with elevated fc_modified_inodes_size
and the next call to ext4_fc_record_modified_inode() can modify
fc_modified_inodes[] out of bounds.

In addition to checking the return value we should probably also move
incrementing the fc_modified_inodes_size until after the successful
reallocation in order to avoid such pitfalls.

Thanks!
-Lukas

> 
> 					- Ted
> 
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> > ---
> >  fs/ext4/fast_commit.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 8ea5a81..8d5d044 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -1660,7 +1660,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
> >  		return 0;
> >  	}
> >  
> > -	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> > +	ext4_fc_record_modified_inode(sb, inode->i_ino);
> >  
> >  	start = le32_to_cpu(ex->ee_block);
> >  	start_pblk = ext4_ext_pblock(ex);
> > @@ -1785,7 +1785,7 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
> >  		return 0;
> >  	}
> >  
> > -	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> > +	ext4_fc_record_modified_inode(sb, inode->i_ino);
> >  
> >  	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
> >  			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
> > -- 
> > 2.15.2
> > 
> > 
> 

