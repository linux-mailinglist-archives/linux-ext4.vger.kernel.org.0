Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F535122F0B
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2019 15:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfLQOnB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 09:43:01 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:39893 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfLQOnA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Dec 2019 09:43:00 -0500
Received: by mail-io1-f45.google.com with SMTP id c16so9340193ioh.6
        for <linux-ext4@vger.kernel.org>; Tue, 17 Dec 2019 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DnG8LQB1yJLF/Vgpa2x9Qk2BJUHJSsJUtoE8okLro8I=;
        b=nHexgJ0l04jkSTArkRlaLw6fAE0zKk7s+IkXh/P2ARr2DYSLxuxuaV84gWaEOihM8u
         ckgqAnz0l1b2YAXo5S0fFwSP933G+o9XJWhml8yFNy5my0QLTTKr52pdf1I3j1sA5x2V
         3077Y4zgVwVHyAn8NfumS+ibj41SHOpJSyx/d57CsjN63HCSbbev2fe6sVIjzW7xENOK
         AqI3RqklnvXNF5mTz0LP0CUn4gh5AjDGxzSsE9icGKgf6j921tObjX3lajz/6tXl9Fwu
         rc8SoUEsnJyftfhllNxj7h214Ul+km/MjGgGCwFAQiKVXvCuLC6JOUB+NurWTRsIPLOi
         qXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DnG8LQB1yJLF/Vgpa2x9Qk2BJUHJSsJUtoE8okLro8I=;
        b=pW7gECYUf7zRH6A1+tSRf+t/xFJg3nYXZ81ZFXiw/gvVAjkgLOmvIuaM/2Gzk20uwt
         N/T+coAOgP3gWhJYblE7UwDGLVQbF/VrQxtvTA4WLV9hlxTZthDAqNf9xrCzq6C2UoS3
         k1QIefyFQCvE0XmlGOP9PX/ODPvGEaq2VP7R2RVBewRLVUQoTiRQpFH78w+ovPDIuvQW
         RHPJvvp33GJWzMjIv+OoCYmJTwGRX+80ZA52e0ieAXYB1tLdrBB0cCpaLZ7iqZaadXb4
         9SMuwRymqXe5812FFsCiwxyMdO9WIHI+OX5Tsz7Rch5gAzYjNcqApdlXtq8+/xsI9vl2
         yCSg==
X-Gm-Message-State: APjAAAWgrQKw0KcueL/PTSrUofkPHdKXUq7a8T9+BDFDLxaRnFZUr7UA
        ObkIcbWaCV2yV6bF/gYG3lHGFy/XPbZF/oo2IhcsFxAOVkc=
X-Google-Smtp-Source: APXvYqyWhuspQnn9vJOr4mhFpWDaHwobRgBBQg1l3Vcml2t6gknWs5aBb27M7SXxPoUHYRJZvdwurPFDNXlUjAKH7c0=
X-Received: by 2002:a02:3946:: with SMTP id w6mr17584993jae.9.1576593779786;
 Tue, 17 Dec 2019 06:42:59 -0800 (PST)
MIME-Version: 1.0
References: <CAMoswejffB4ys=2C5zL_j9SBrdka8MJWV3hpwber9cggo=1GQQ@mail.gmail.com>
 <20191213155912.GH15474@quack2.suse.cz>
In-Reply-To: <20191213155912.GH15474@quack2.suse.cz>
From:   Paul Richards <paul.richards@gmail.com>
Date:   Tue, 17 Dec 2019 14:42:48 +0000
Message-ID: <CAMoswegmo08i-7TMpbM7x=RHiRsu-g40Vq2wmPzYsx7=gCi5MA@mail.gmail.com>
Subject: Re: Query about ext4 commit interval vs dirty_expire_centisecs
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 13 Dec 2019 at 15:59, Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Tue 19-11-19 08:47:31, Paul Richards wrote:
> > I'm trying to understand the interaction between the ext4 `commit`
> > interval option, and the `vm.dirty_expire_centisecs` tuneable.
> >
> > The ext4 `commit` documentation says:
> >
> > > Ext4 can be told to sync all its data and metadata every 'nrsec' seco=
nds. The default value is 5 seconds. This means that if you lose your power=
, you will lose as much as the latest 5 seconds of work (your filesystem wi=
ll not be damaged though, thanks to the journaling).
> >
> > The `dirty_expire_centisecs` documentation says:
> >
> > > This tunable is used to define when dirty data is old enough to be el=
igible for writeout by the kernel flusher threads. It is expressed in 100't=
hs of a second. Data which has been dirty in-memory for longer than this in=
terval will be written out next time a flusher thread wakes up.
> >
> >
> > Superficially these sound like they have a very similar effect.  They
> > periodically flush out data that hasn't been explicitly fsync'd by the
> > application.  I'd like to understand a bit more the interaction
> > between these.
>
> Yes, the effect is rather similar but not quite the same. The first thing
> to observe is kind of obvious fact that ext4 commit interval influences
> just the particular filesystem while dirty_expire_centisecs influences
> behavior of global writeback over all filesystems.
>
> Secondly, commit interval is really the maximum age of ext4 transation.  =
So
> if there is metadata change pending in the journal, it will become
> persistent at latest after this time. So for say 'mkdir' that will be
> persistent at latest after this time. For data operations things are more
> complex. E.g. when delayed allocation is used (which is the default), the
> change gets logged in the journal only during writeback. So it can take u=
p
> to dirty_expire_centisecs for data to be written back from page cache, th=
at
> results in filesystem journalling block allocations etc. and then it can
> take upto commit interval for these changes to become persistent. So in
> this case the intervals add up. There are also other special cases
> somewhere in between but generally it is reasonable to assume that data g=
ets
> automatically persistent in dirty_expire_centisecs + commit_interval time=
.
> Note both these times are actually times when writeback is triggered so
> if the disk gets too busy, the actual time when data is completely on dis=
k
> may be much higher.
>

Thanks for taking the time to reply!

Since automatic persisting of data occurs only after
dirty_expire_centisecs + commit_interval,
should the ext4 docs be corrected?  They currently state (for the
commit interval option):

"The default value is 5 seconds. This means that if you lose
your power, you will lose as much as the latest 5 seconds of work"
