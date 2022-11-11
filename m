Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3172A625DFC
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 16:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiKKPNv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 10:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiKKPNL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 10:13:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F479BE1D
        for <linux-ext4@vger.kernel.org>; Fri, 11 Nov 2022 07:10:30 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id E52E820B717A; Fri, 11 Nov 2022 07:10:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E52E820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668179429;
        bh=kNql9UwdujqJn1tN/XNgr1MRdAW8aEtdgstCyNpFSz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWreDnsAU8qJQc7jEGaG/whV9H+vXAvdQsv1QV1nQtaSXVj2bFElCAhEYgNb/Bf47
         fSKD5gJQTiH+evGDvhH6PFtuUHp+StVNrIkbKF+7IdHu8vxleQEtRb0f9pf7TcmAVh
         JqtJXM06N5WQY3SU9q746//NSSIVPeQ9hVb+PGJ4=
Date:   Fri, 11 Nov 2022 07:10:29 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221111151029.GA27244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
 <20221014132543.i3aiyx4ent4qwy4i@quack3>
 <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
 <20221024104628.ozxjtdrotysq2haj@quack3>
 <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
 <20221026101854.k6qgunxexhxthw64@quack3>
 <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221110152637.g64p4hycnd7bfnnr@quack3>
 <20221110192701.GA29083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111142424.vwt4khbtfzd5foiy@quack3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111142424.vwt4khbtfzd5foiy@quack3>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 11, 2022 at 03:24:24PM +0100, Jan Kara wrote:
> On Thu 10-11-22 11:27:01, Jeremi Piotrowski wrote:
> > On Thu, Nov 10, 2022 at 04:26:37PM +0100, Jan Kara wrote:
> > > On Thu 10-11-22 04:57:58, Jeremi Piotrowski wrote:
> > > > On Wed, Oct 26, 2022 at 12:18:54PM +0200, Jan Kara wrote:
> > > > > On Mon 24-10-22 18:32:51, Thilo Fromm wrote:
> > > > > > Hello Honza,
> > > > > > 
> > > > > > > Yeah, I was pondering about this for some time but still I have no clue who
> > > > > > > could be holding the buffer lock (which blocks the task holding the
> > > > > > > transaction open) or how this could related to the commit you have
> > > > > > > identified. I have two things to try:
> > > > > > > 
> > > > > > > 1) Can you please check whether the deadlock reproduces also with 6.0
> > > > > > > kernel? The thing is that xattr handling code in ext4 has there some
> > > > > > > additional changes, commit 307af6c8793 ("mbcache: automatically delete
> > > > > > > entries from cache on freeing") in particular.
> > > > > > 
> > > > > > This would be complex; we currently do not integrate 6.0 with Flatcar and
> > > > > > would need to spend quite some effort ingesting it first (mostly, make sure
> > > > > > the new kernel does not break something unrelated). Flatcar is an
> > > > > > image-based distro, so kernel updates imply full distro updates.
> > > > > 
> > > > > OK, understood.
> > > > > 
> > > > > > > 2) I have created a debug patch (against 5.15.x stable kernel). Can you
> > > > > > > please reproduce the failure with it and post the output of "echo w
> > > > > > > > /proc/sysrq-trigger" and also the output the debug patch will put into the
> > > > > > > kernel log? It will dump the information about buffer lock owner if we > cannot get the lock for more than 32 seconds.
> > > > > > 
> > > > > > This would be more straightforward - I can reach out to one of our users
> > > > > > suffering from the issue; they can reliably reproduce it and don't shy away
> > > > > > from patching their kernel. Where can I find the patch?
> > > > > 
> > > > > Ha, my bad. I forgot to attach it. Here it is.
> > > > > 
> > > > 
> > > > Unfortunately this patch produced no output, but I have been able to repro so I
> > > > understand why: except for the hung tasks, we have 1+ tasks busy-looping through
> > > > the following code in ext4_xattr_block_set():
> > > > 
> > > > inserted:
> > > >         if (!IS_LAST_ENTRY(s->first)) {
> > > >                 new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
> > > >                                                      &ce);
> > > >                 if (new_bh) {
> > > >                         /* We found an identical block in the cache. */
> > > >                         if (new_bh == bs->bh)
> > > >                                 ea_bdebug(new_bh, "keeping");
> > > >                         else {
> > > >                                 u32 ref;
> > > > 
> > > >                                 WARN_ON_ONCE(dquot_initialize_needed(inode));
> > > > 
> > > >                                 /* The old block is released after updating
> > > >                                    the inode. */
> > > >                                 error = dquot_alloc_block(inode,
> > > >                                                 EXT4_C2B(EXT4_SB(sb), 1));
> > > >                                 if (error)
> > > >                                         goto cleanup;
> > > >                                 BUFFER_TRACE(new_bh, "get_write_access");
> > > >                                 error = ext4_journal_get_write_access(
> > > >                                                 handle, sb, new_bh,
> > > >                                                 EXT4_JTR_NONE);
> > > >                                 if (error)
> > > >                                         goto cleanup_dquot;
> > > >                                 lock_buffer(new_bh);
> > > >                                 /*
> > > >                                  * We have to be careful about races with
> > > >                                  * adding references to xattr block. Once we
> > > >                                  * hold buffer lock xattr block's state is
> > > >                                  * stable so we can check the additional
> > > >                                  * reference fits.
> > > >                                  */
> > > >                                 ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
> > > >                                 if (ref > EXT4_XATTR_REFCOUNT_MAX) {
> > > >                                         /*
> > > >                                          * Undo everything and check mbcache
> > > >                                          * again.
> > > >                                          */
> > > >                                         unlock_buffer(new_bh);
> > > >                                         dquot_free_block(inode,
> > > >                                                          EXT4_C2B(EXT4_SB(sb),
> > > >                                                                   1));
> > > >                                         brelse(new_bh);
> > > >                                         mb_cache_entry_put(ea_block_cache, ce);
> > > >                                         ce = NULL;
> > > >                                         new_bh = NULL;
> > > >                                         goto inserted;
> > > >                                 }
> > > > 
> > > > The tasks keep taking the 'goto inserted' branch, and never finish. I've been
> > > > able to repro with kernel v6.0.7 as well.
> > > 
> > > Interesting! That makes is much clearer (and also makes my debug patch
> > > unnecessary). So clearly the e_reusable variable in the mb_cache_entry got
> > > out of sync with the number of references really in the xattr block - in
> > > particular the block likely has h_refcount >= EXT4_XATTR_REFCOUNT_MAX but
> > > e_reusable is set to true. Now I can see how e_reusable can stay at false due
> > > to a race when refcount is actually smaller but I don't see how it could
> > > stay at true when refcount is big enough - that part seems to be locked
> > > properly. If you can reproduce reasonably easily, can you try reproducing
> > > with attached patch? Thanks!
> > > 
> > 
> > Sure, with that patch I'm getting the following output, reusable is false on
> > most items until we hit something with reusable true and then that loops
> > indefinitely:
> 
> Thanks. So that is what I've suspected. I'm still not 100% clear on how
> this inconsistency can happen although I have a suspicion - does attached
> patch fix the problem for you?
> 
> Also is it possible to share the reproducer or it needs some special
> infrastructure?
> 
> 								Honza

I'll test the patch and report back.

Attached you'll find the reproducer, for me it reproduces within a few minutes.
It brings up a k8s node and then runs 3 instances of the application which
creates a lot of small files in a loop. The OS we run it on has selinux enabled
in permissive mode, that might play a role.

> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> >From 6132433e400ff7be348fe04fdf8ee67eb105ec21 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Thu, 10 Nov 2022 16:22:06 +0100
> Subject: [PATCH] ext4: Lock xattr buffer before inserting cache entry
> 
> ---
>  fs/ext4/xattr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 36d6ba7190b6..02e265bb94e2 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2970,15 +2970,18 @@ ext4_xattr_block_cache_insert(struct mb_cache *ea_block_cache,
>  			      struct buffer_head *bh)
>  {
>  	struct ext4_xattr_header *header = BHDR(bh);
> -	__u32 hash = le32_to_cpu(header->h_hash);
> -	int reusable = le32_to_cpu(header->h_refcount) <
> -		       EXT4_XATTR_REFCOUNT_MAX;
> +	__u32 hash;
> +	int reusable;
>  	int error;
>  
>  	if (!ea_block_cache)
>  		return;
> +	lock_buffer(bh);
> +	hash = le32_to_cpu(header->h_hash);
> +	reusable = le32_to_cpu(header->h_refcount) < EXT4_XATTR_REFCOUNT_MAX;
>  	error = mb_cache_entry_create(ea_block_cache, GFP_NOFS, hash,
>  				      bh->b_blocknr, reusable);
> +	unlock_buffer(bh);
>  	if (error) {
>  		if (error == -EBUSY)
>  			ea_bdebug(bh, "already in cache");
> -- 
> 2.35.3
> 


--5mCyUwZo2JvN/JJP
Content-Type: application/x-sh
Content-Disposition: inline; filename="issue-847-repro.sh"
Content-Transfer-Encoding: 8bit

#!/bin/bash

curl -sfL https://get.k3s.io | sh -
while ! sudo kubectl get node ; do
  sleep 1
done

cat >manifest.yml <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: io-test
  labels: 
    app: io-test
spec:
  replicas: 3
  selector:
    matchLabels:
      app: io-test
  template:
    metadata:
      labels:
        app: io-test
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: kubernetes.io/hostname
                    operator: In
                    values:
                      - $HOSTNAME
      containers:
        - name: io-test
          image: golang:1.19.1
          command:
          - bash
          - -c
          - |
            apt update && apt install time -y
            echo '
              package main

              import (
                "fmt"
                "log"
                "os"
              )

              func main() {
                suffix := ""
                if len(os.Args) > 1 {
                  suffix = os.Args[1]
                }

                err := run(suffix)
                if err != nil {
                  log.Fatal(err)
                }
              }

              func run(suffix string) error {
                for i := 0; i < 100_000; i++ {
                  if i%10_000 == 0 {
                    log.Printf("file #%d", i)
                  }

                  path := fmt.Sprintf("file_%d_%s", i, suffix)
                  content := path
                  err := os.WriteFile(path, []byte(content), 0644)
                  if err != nil {
                    return err
                  }
                }

                return nil
              }
            ' >> /test/main.go
            cd /test
            go build main.go

            while true
            do
              time ./main \$(date +%s)
            done
          volumeMounts:
          - name: io-test
            mountPath: "/test"
      restartPolicy: Always
      volumes:
        - name: io-test
          emptyDir: {}
EOF

sudo kubectl apply -f manifest.yml
sudo kubectl get pods -w
--5mCyUwZo2JvN/JJP--
