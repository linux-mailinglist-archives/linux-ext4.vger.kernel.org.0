Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC922489
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2019 20:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfERS7n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 May 2019 14:59:43 -0400
Received: from sonic305-20.consmr.mail.gq1.yahoo.com ([98.137.64.83]:42951
        "EHLO sonic305-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727600AbfERS7n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 18 May 2019 14:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1558205980; bh=IrP9JerFDA30T99wGhjSoOscFHB4QdQuHUSO9iAJ0E8=; h=Date:From:Subject:To:References:In-Reply-To:From:Subject; b=Iet3PjehhQBbEs4XCbdacbB24/PhbWqtk7nTcR7GgDwDc7NI6YbGiHm+D0sIeK5qk1IPA7V8O9QoBfEauAZLoEWN6z0IAUSD3KvzVEpMhJWC3dtgUf5tj3kEd/kVm8CNZXuxXZEnDMe9eyWV/ZoCQDj+SOSvyh6DAOFTi6HogsogoJEJe8wyl3oREXdNGQf3j+95b7FGs2NDnBuruVX5lAzTPCD7QY9Opy7QTpuHfxrlxGvBcE3GGFzbjAgcOg2uGhBbwCYcaiDEbr9WWNqp4zVm1/GU5oBT+HBGJrkNeMvBjV8Q034TjNzFZ4r1YUbiaK0LeCvP/sIt3QYkSV+Eew==
X-YMail-OSG: 6Bx4DOQVM1kM1pI_028vHt1dPHOjOYDqiNJCVJLTW0vgnfMUTHJ4N2Y3es84Q1n
 hJiCzBtTjhQE0mxorBkFefHzmFzW_.mnNEXrdqePIUNnWGbwd6R2uo4_nNubuMjsjDnmOhEUyKdW
 _Ji.NHGU91OEA9UmoPUtZ.Io4RIspApRi74LzA0kUeS2j_A0tW3DnD_xwYkBnLOinujEqNpnX.J7
 Bzx72FxQbbY.j.ZfvFCk76G1qswIoXAE9kVigICiENIEq.d3wBIjNDByiH.KiET04Rydj6xRjv0Q
 kIAW.qxJpSMGKTPwm9LJQhpZXHAAqmiePY3XmFTOmcG50heLD89OWXqmADLhDaoqu6m4od9JCDG3
 F1oFX4673TGl0Od_9g8dE3kckkCjxvsir346jIAvOrWUZguTVKP3YUHgQiyYq7YbgqYHujToX42x
 9QSmTpcyP6DKZqI6cWebegiEcFZtE42QlIDudtik3SGZ2Etw3mSBKyJdtoNj2We1cLRp8cBADjLi
 9PHaTCKrYuoNDcitkA4JMkdAXBDZTXwlYYvkDPE8tAk4xp1X2Iw9te1MJaeCw6Ur18oQi3srYyjt
 snQ8WSdVq0UB_zDna4IVifydRYrJxjicVfK4Ez_1hExSa9YUdQDwkHiuksvp1tzZWARX0oq0GV2G
 wjEylQF6MUny9kqCxL.Erq1h9Pc4csbjoZ0FHfVvSWsz9u5.eH6vp4NThHOHjYq82GGAN10.kwNC
 YPWblmBuxpaEh5XEzmwLxFfFSbgsWKXF.K5WCLQy9Su7Bmtnuh5IDMIID.SsdbyV_VTcEOILSzt0
 xNSLh.UWkapx3gUqW9v3fW3Sa09hIyE5QeTZgsqWPWuYc8jDJ4Ik0stgJOmOu6izk.FFJ6Dp5c9s
 7D9q99cmeKRcoQ3HMgki5hobgaWaVH6wFrYpYMxr5pWwTZqXNpV8z7zyzKVT.aLSZuTQAIcdvuRH
 EfcxAI9mVAXE9vz3wJj366n612YGNjKXMZsHT4cGfTV81qf.JRZRx1sIoFr5pN.fVOmBekvnOAQm
 Fjp6l2lcI61QRmKrdKh1pSDfoqgK18FQ4p7Hu3_5vcoIn4igUhUVZVwG4e5zrt8aHvqWIHns5AIt
 NJq5T3xM7xwCyN.qIUKPBG1zX4Yc6wHViZHhtxFz2ttttFpCeRow.yW9Q8hnZ9om_r9E1j9m1pxw
 utO3SL54hMHJoDEXEDQ9k.Mh8KQyMFH2hM0IXzj2yxpwG7eFfFHQzN85clOxA_gN3jXRfHQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Sat, 18 May 2019 18:59:40 +0000
Received: from CPE00fc8de26033-CM00fc8de26030.cpe.net.cable.rogers.com (EHLO localhost) ([99.228.156.240])
          by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 38d8e7f99c75f9e57aa7564c5ea29efe;
          Sat, 18 May 2019 18:59:37 +0000 (UTC)
Date:   Sat, 18 May 2019 14:59:29 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [bugreport] kernel 5.2 pblk bad header/extent: invalid extent
 entries
To:     linux-ext4@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsNPMSQgBjnFarYaxuQEGpA1G=U4U9OHqT0E53pNL2BK8g@mail.gmail.com>
        <CABXGCsNV6EQq0EG=iO8mWCCv9da__9iyLmwyzS3nGtjjvhShfg@mail.gmail.com>
In-Reply-To: <CABXGCsNV6EQq0EG=iO8mWCCv9da__9iyLmwyzS3nGtjjvhShfg@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1558205941.pbpzbe25nt.astroid@alex-desktop.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Excerpts from Mikhail Gavrilov's message of May 18, 2019 7:07 am:
> On Sat, 18 May 2019 at 11:44, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>> [28616.429757] EXT4-fs error (device nvme0n1p2): ext4_find_extent:908:
>> inode #8: comm jbd2/nvme0n1p2-: pblk 23101439 bad header/extent:
>> invalid extent entries - magic f30a, entries 8, max 340(340), depth
>> 0(0)


I had a similar problem today:

EXT4-fs error (device dm-0): ext4_find_extent:908: inode #8: comm jbd2/dm-0=
-8: pblk 117997567 bad header/extent: invalid extent entries - magic f30a, =
entries 8, max 340(340), depth 0(0)

I am using dm-crypt on SATA disk.
