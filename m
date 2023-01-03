Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF3865C524
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 18:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjACRem (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 12:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjACRel (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 12:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7301310FFF
        for <linux-ext4@vger.kernel.org>; Tue,  3 Jan 2023 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672767235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UXDgMAks1AazXUGyay5LaZWRCzaIyOQrM1gFj8TREZA=;
        b=ZUw5AUgg72419UyUNuvawPJnMZTPJbQLe4Dkh8ZL/K9Ouzi13KR5OVcBGcKdKq05AZWu2Z
        2zB01tmaK067U7TKmhE6s3/24HUA6mcWRjkm7ffUBSgaK8ipGzE5JVmy7Lwh3urXvKuZrB
        sPJRvBf0MUACXLjDQhUxMpr3s2y6doM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-258-zPTPOqcINnCmL0KnlspE8Q-1; Tue, 03 Jan 2023 12:33:54 -0500
X-MC-Unique: zPTPOqcINnCmL0KnlspE8Q-1
Received: by mail-pf1-f200.google.com with SMTP id n22-20020a62e516000000b005817b3a197aso7982077pff.14
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jan 2023 09:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXDgMAks1AazXUGyay5LaZWRCzaIyOQrM1gFj8TREZA=;
        b=0yTkfn9p2jSacoFJtl4q9/KBKBoi7JDvOFZ/O7a0UuDg3Mso3zOEaIG9j+rAQLze30
         HUE2C4BBCvMRvccmwA9YqNbuxPDImTPfwNJlRvV5+iFKbNuSlnaQDBowganZNCGZGQ1h
         HIU1tZzv73v4awmKr1ns41U2P7p9gmU+cZTaiLMqbJAdNt7D6zhogNrSeTTGw+wfTJRu
         +0Za6ZyIFTna6z6K95F1TrKRQUulodABYAqWn9dmMnEyuY0xxlFY7EHJ7V6b0EKqKEnk
         /urZJ4Wip+2cxhtMTpWaDPBSooSaeIh7vRYfo4NlGUtx/PJy11g7BCC0F0yCrk9xMbk2
         aJJw==
X-Gm-Message-State: AFqh2kpjZKc+qZosyGb9ISntTNRv6qq6l5fyD2FAY+f5ibP+V0E5ubf2
        T4ybccKO+ptJoSGJWfJP3WVhNkeC3vh0865BIfLsYw036Hg2wJdyS5JbwbrPXixLKIhwsARbjlI
        y/DOkkLGG1yjivCu0cwoQjA==
X-Received: by 2002:a62:506:0:b0:56c:7216:fbc6 with SMTP id 6-20020a620506000000b0056c7216fbc6mr45392818pff.30.1672767233039;
        Tue, 03 Jan 2023 09:33:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvgHh1xR0yEYEOLNIiw2a9F0DnNeFqj2kH9NAQba47uamtEX+WHHc7rIQEwtK/YqVreiCWpbA==
X-Received: by 2002:a62:506:0:b0:56c:7216:fbc6 with SMTP id 6-20020a620506000000b0056c7216fbc6mr45392803pff.30.1672767232672;
        Tue, 03 Jan 2023 09:33:52 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79575000000b005812e832087sm15452620pfq.29.2023.01.03.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:33:52 -0800 (PST)
Date:   Tue, 3 Jan 2023 17:33:48 +0000
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Verify extent header in ext4_find_extent()
Message-ID: <Y7Rm/AOlmaGp0JaL@kernel-devel>
References: <20230102145833.2758-1-syoshida@redhat.com>
 <Y7NkW86aVcksg3i9@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7NkW86aVcksg3i9@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 02, 2023 at 03:10:19PM -0800, Eric Biggers wrote:
> On Mon, Jan 02, 2023 at 02:58:33PM +0000, Shigeru Yoshida wrote:
> > syzbot reported use-after-free in ext4_find_extent() [1].  If there is
> > a corrupted file system, this can cause invalid memory access.
> > 
> > This patch fixes the issue by verifying extent header.
> > 
> > Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?id=cd95cb722bfa1234ac4c78345c8953ee2e7170d0 [1]
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> >  fs/ext4/extents.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 9de1c9d1a13d..79bfa583ab1d 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -901,6 +901,9 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
> >  		ret = -EFSCORRUPTED;
> >  		goto err;
> >  	}
> > +	ret = ext4_ext_check(inode, eh, depth, 0);
> > +	if (ret)
> > +		goto err;
> 
> This patch probably does not address the root cause of the problem.  Please see
> the discussion on the very similar patch
> https://lore.kernel.org/linux-ext4/20221230062931.2344157-1-tudor.ambarus@linaro.org/T/#u

Thank you so much for your comment!!  I missed the discussion you
mentioned.  I'll check that.

Regards,
Shigeru

> 
> - Eric
> 

