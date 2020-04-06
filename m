Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BED19F521
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Apr 2020 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgDFLuZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 07:50:25 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:51967 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgDFLuY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 07:50:24 -0400
Received: by mail-pj1-f45.google.com with SMTP id fr8so1221029pjb.1
        for <linux-ext4@vger.kernel.org>; Mon, 06 Apr 2020 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:in-reply-to:references:mime-version:content-id
         :date:message-id;
        bh=awKz0/iNJQiWayxHfSTFbdaCSqFrYL0PlHZ1+wPxwiA=;
        b=GuBc/UPon4miCzYqDPDf+f7fD1JJHbjaN2rv9pYlQrWGqoFgYKdkridq4vi6NQ6N1x
         bayl6p7peYGG1K+IBzKnVtTzFG65mVhZJWIH4bn0qax2dnN8WBhAmp2mCkQaXuwUnPZ5
         iWVXZzXHmJjkBuXG6n6f74wEx32S4vOq9VDjaGwgoYtsIDXnWJVlqVDAfGe5MXC3whPx
         rE3NQkBoHctIg/zGRQBk9ZZ9Ewmlaz0Ia/+7Af19gcmijeEGHDprWvpLaaiHchJKmvKq
         8d5F+d4MsT7da54lXWzNHZ4SrkHDdT/+go6IVc9McvZmcYsCzn7IWAr5bzZgN/MBjBdq
         IhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:in-reply-to:references
         :mime-version:content-id:date:message-id;
        bh=awKz0/iNJQiWayxHfSTFbdaCSqFrYL0PlHZ1+wPxwiA=;
        b=bW8ky13z/75N+JOOueZZ1hIL9O5iX6NKZL5BW07ooEBArtADFG2Kvw5U1dBvOMg6lK
         EwKlZX7rXfhUvFQvL/6Q+QDjeO0pF8i8rTGXjXxZWDaQ/mLvx1DOeH8zcRogP/uLB7/E
         3Ny8sK37/LRAizz9xg7pXZOM1dPMKumEbTh2PhYbDa4fYtnVLkBJOrY+ychHXNh8WDRQ
         NeudDnDyhqdPzv6Kg1upHXMPVJjzRdB/+AbdWXIahvyFSeOs23lxNhfsnLrXDAEZV1Xw
         D9LbLptJ0l47M2a2qYI2uGqRaoT+9/I1ZxYSHK64sEG7JkYFz1DeaoT710TclWjk/JeL
         XrYw==
X-Gm-Message-State: AGi0PuaP/7urm3zyIe4Acc+23BkRbYsw95Tm1R9drReVNAqKNcSbzzIm
        VZ8JU4bJaBdTqjZssg8HiJWu3swE
X-Google-Smtp-Source: APiQypJyElfT1fYETXd7wpw+DklKfBkm/V+dM1drbXLcX2F6ciNfWewxNBiQ7F0/rtJ3zEpq6zIe9g==
X-Received: by 2002:a17:90a:c20b:: with SMTP id e11mr25776592pjt.57.1586173823464;
        Mon, 06 Apr 2020 04:50:23 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id 135sm11782420pfu.207.2020.04.06.04.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 04:50:23 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1jLQGj-0005Xw-PP ; Mon, 06 Apr 2020 20:50:21 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v2] ext2: Silence lockdep warning about reclaim under xattr_sem
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
In-Reply-To: <20200406102148.GC1143@quack2.suse.cz>
References: <20200225120803.7901-1-jack@suse.cz> <30602.1586151377@jrobl> <20200406102148.GC1143@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21322.1586173821.1@jrobl>
Date:   Mon, 06 Apr 2020 20:50:21 +0900
Message-ID: <21323.1586173821@jrobl>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Kara:
> to serialize anything. But from a maintenance point of view it is better to
> acquire the lock so that possible assertions that lock is held in some
> helper functions don't barf or for the case the function gets used in a
> different code path in the future.

Ok, thanx.
"a maintenance point of view" is a good keyword for me.
I will post "the fix passed my local stress test" tomorrow.


J. R. Okajima
