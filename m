Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23B4390D23
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 02:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhEZAC3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 May 2021 20:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229939AbhEZAC2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 May 2021 20:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621987257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vOiyAqWxxuaxXY+3q9km4psaaYiAnLD8wrsG1M/Mujs=;
        b=QIKZJPBZ+o/4at5Voa5QzhBX+K6wBPB5Slclilywl5iTQpjFnCUHNP2NFtcHcXA+tNFlMT
        n3pv/6jFmJR60tZoY9MAGUISwfR6p5nJFWuviT1hf6kDPZ/GxUJqOFaFrK4OYlQhwhKhmL
        sgd4OoiV9ztZ+7M8L2FBBUAKbUYOwk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-d4YTweP6N0SWjAI4Kiwk0g-1; Tue, 25 May 2021 20:00:55 -0400
X-MC-Unique: d4YTweP6N0SWjAI4Kiwk0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C2581883520;
        Wed, 26 May 2021 00:00:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B39F25D6AC;
        Wed, 26 May 2021 00:00:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <00224B62-4903-4D33-A835-2DC8CC0E3B4D@dilger.ca>
References: <00224B62-4903-4D33-A835-2DC8CC0E3B4D@dilger.ca> <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca> <206078.1621264018@warthog.procyon.org.uk> <4169583.1621981910@warthog.procyon.org.uk>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     dhowells@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs directories?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4176732.1621987227.1@warthog.procyon.org.uk>
Date:   Wed, 26 May 2021 01:00:27 +0100
Message-ID: <4176733.1621987227@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> wrote:

> > Any thoughts on how that might scale?  vfs_tmpfile() doesn't appear to
> > require the directory inode lock.  I presume the directory is required for
> > security purposes in addition to being a way to specify the target
> > filesystem.
> 
> I don't see how that would help much?

When it comes to dealing with a file I don't have cached, I can't probe the
cache file to find out whether it has data that I can read until I've opened
it (or found out it doesn't exist).  When it comes to writing to a new cache
file, I can't start writing until the file is created and opened - but this
will potentially hold up close, data sync and writes that conflict (and have
to implicitly sync).  If I can use vfs_tmpfile() to defer synchronous
directory accesses, that could be useful.

As mentioned, creating a link to a temporary cache file (ie. modifying the
directory) could be deferred to a background thread whilst allowing file I/O
to progress to the tmpfile.

David

