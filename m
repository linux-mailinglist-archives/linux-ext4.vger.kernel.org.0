Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8286C0096
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Mar 2023 11:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCSKxs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Mar 2023 06:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCSKxr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Mar 2023 06:53:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB1C113C1;
        Sun, 19 Mar 2023 03:53:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so36375854ede.8;
        Sun, 19 Mar 2023 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679223224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Axr9HywQ8790Sf7fL41EwtcJKBQNRMV++khYmiO6pMY=;
        b=FKErBK/J5YZ1SHDs0/gRY2D7JYHymUeNY1lH62w/oXxGRw4ipAZuiDOgfK2YTfcc+7
         Um86xrWCxHKlUX0hHwuhrWIOYKAtvG9y0hh/1AR685XKjIPK0IJregwDWKFMSd9Rp1Dp
         fUYsLSNqRCicJsdzbCAFoU4Zrb8Rz24+3uv+9qG3h8GCawq6rg7uT84PdQMtj/6Hxb4f
         dkBWV6cdZ2pbwMsH80W5m5VM430uVECuy1ejVsGClwgwvKanAr541gfL/WU9fbYwXrVu
         GcJzOb/X6+NhUVvqOWqTLoufDhh+6C873ydeUj8VnuJdqqNFIKynJ5RpxdcqwJUVaUY8
         AAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679223224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axr9HywQ8790Sf7fL41EwtcJKBQNRMV++khYmiO6pMY=;
        b=RIr0vkazzMfjWqZOKfbt9vxW1XocPCAwDScS10agzTtbzey6K81BTH+nUgiWcX0ZHU
         cFcQXAuZxHEKSaQdPkOxsX3kwMpq6Jc1UX0mhiIrcVJ0J1N1fXmYzlIZycBTYwHhWwNK
         TC2BfnGna1LQh1sVd5sxHFfB14zSaZ0uv5aE7n2Nizs8tsU5sgViuJF95AQPETQXRvNE
         XqbYTx3ue+CrFEMqoncZNUuYQwQ65iKYr2WYpN2Waa02qxmmJO9hOifliLFdu9tC0AFB
         nLGzDbFeJR1AwvqqXs85mXllav7vG4I2qiXheO8O6oHxKEx9EKZxJGaz/0A/Zdtk8dir
         SLiw==
X-Gm-Message-State: AO0yUKXlypBe7gRSVKvPG+XyX/GG1WHGe73gOVYmARnlEzRoUJYNWKkU
        UsnGgoJIDmW3itVBNed3yBFVlnD0VjE=
X-Google-Smtp-Source: AK7set8BDxJTy8SUkvQ0u1q74EE1PzlYcZscYrHYugoj8oObY73BX86JvyTg38WSog3yNhcK3YAYzA==
X-Received: by 2002:a17:907:20af:b0:924:7f98:7c55 with SMTP id pw15-20020a17090720af00b009247f987c55mr5148820ejb.48.1679223223623;
        Sun, 19 Mar 2023 03:53:43 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id yj8-20020a170907708800b00930170bc292sm3110020ejb.22.2023.03.19.03.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 03:53:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 19 Mar 2023 11:53:40 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 1/1] ext4: Replace ext4_kvfree_array_rcu() by
 kvfree_rcu_mightsleep()
Message-ID: <ZBbptCj8j3gWVesY@pc636>
References: <20230317071558.335645-1-urezki@gmail.com>
 <28e1585c-7062-49c2-b08e-a5d33ca06577@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e1585c-7062-49c2-b08e-a5d33ca06577@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 17, 2023 at 05:31:04PM -0700, Paul E. McKenney wrote:
> On Fri, Mar 17, 2023 at 08:15:58AM +0100, Uladzislau Rezki (Sony) wrote:
> > The ext4_kvfree_array_rcu() function was introduced in order to
> > release some memory after a grace period during resizing of a
> > partition. An object that is freed does not contain any rcu_head
> > filed.
> > 
> > To do so, it requires to allocate some extra memory for a special
> > structure that has an rcu_head filed and pointer one where a freed
> > memory is attached. Finally call_rcu() API is invoked.
> > 
> > Since we have a single argument of kvfree_rcu() API, we can easily
> > replace all that tricky code by one single call that does the same
> > but in more efficient way.
> > 
> > Cc: linux-ext4@vger.kernel.org
> > Cc: Lukas Czerner <lczerner@redhat.com>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> From an RCU perspective:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
Thank you!

--
Uladzislau Rezki
