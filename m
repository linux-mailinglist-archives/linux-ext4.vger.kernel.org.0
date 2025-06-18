Return-Path: <linux-ext4+bounces-8513-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926FAADEA7A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E14517C6E7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35C2E3B0D;
	Wed, 18 Jun 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bxYLMYIQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E22DE1FF
	for <linux-ext4@vger.kernel.org>; Wed, 18 Jun 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246811; cv=none; b=glwEMdEXSokNNLLctNpgVBklX0rOyT+ivueD42uW+fUVzBdYP2Yf3clv2kX5honAjMENzRb6seAPOzZo9sxAz2Pbx66PCAfgXtASwF0PZpTMlmXAGdZ/SBP9wC/v/p0Yk8tlAFtTny5SqSpHGSxDikpnMHjVGrbKsGkGkmRzgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246811; c=relaxed/simple;
	bh=qO3/5SGtBL45GjxXeAJvBOVL9tI+Tr/hx0vkWhrn4lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WIQT2JUwmty9b5fHCxoJE7cU8hfFKK5YerX0yOlIrZ3f3DMRPBoR82tt2JiWB6Gy9kcBZL6iEFI6raTuO0nVDEguUqXmanVg0SpAopd4HI0x0JyhedwxTiDbid9mbrRafmrUZ/eG0BDcxwwIdU0+Gzq99012oLw8aQmqUgZ+/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bxYLMYIQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2d46760950so7188508a12.3
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jun 2025 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750246809; x=1750851609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RykmkQZwMH+K81hFVCmWyt4XvnWOxmDaIY/LCV05j1s=;
        b=bxYLMYIQ/vDnCDWBEXtOcWhYttyWuWdOfU2Uoe7TmSbYRBT9Wyi3a2F4IU3aZGtJhQ
         3bwJ4lzZUdz2LxMlynZeIXpUmTH1AERD84G1FS9dHHLVN1evrQ44fznaPOCjTCBq7/B2
         nJ7E5kpZtZNMzZsacbk217Zhe6wHCf82aXg0nkm7um/F74Cviu1o+S47zUKgSC9oShTY
         eMeyAItsVud8OJEQyIw657Rqo9aUBL8asLD4CkBLCUnPM2rJSCPkBvS41som/HRGtaC0
         C36xV1VSRf4/GTIQQUwnkjU7hdR91sOpMyHf7R71RSwnBL/3kU5bSIbvMGN4338gJj4l
         2IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750246809; x=1750851609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RykmkQZwMH+K81hFVCmWyt4XvnWOxmDaIY/LCV05j1s=;
        b=kW741GWG1AsXDN9eW/rhbtAeHJQacJW8Dy2ZBwurXw7J8SSqZYhB4vhpt/n3glMW+S
         Ibk/mpxNorACAgKihWytI2JSa5DudmH7OTxR8r5RSyzA+0WY+fXqVaruY5tvJuTl7qf+
         9JSy+zofYr0T3KrWDVf6ap2dpcL6OWLHEu+k5Frrqn+3ObYtZV4y8c0mm34m6fgzFa0n
         oauYugOcHNXw9RZNAfQQ91vWFopZGKpsKEWnxf+ejIhod7mkhSmXLwiv2Ra7kGSG7f/r
         y+0xoEccdyjtPAt5qi2FDxBgwTt62yZsGOykvYG0jtQdo7USAMyqfrThJbQydXutldgD
         5dZg==
X-Forwarded-Encrypted: i=1; AJvYcCUTer3P71t+fcTiNjVus3WvqIITV/vCdllxdF6rvaJf2BcqmiANDHfxOlVG0lq8YCCwLAKhwxEWXvbS@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHmW9pIJngq2/Cz6on8A60yd80fzxmumeQ5HLZIXVQ34oAhyd
	dqR5z6mX6GLs08KURQws6rO1e3Fd99qHbqpoFhht4oloKrsf5tKnJIZwaNbbB2z6IrU=
X-Gm-Gg: ASbGncu0gJXMBk6F+TY3HkQtkZOgzBEtaZIDR5W/IaWmQnCs3Ek133JCfuVG0TTbR/F
	SHZ+14NxXnIAhtcPu5/XrvIOp3gpC36GciswypqQ97t4IHRfg/wkPzeA8+l8PDecJi35TxTE1jM
	gWCBPH43mJGI/h1OICiyHQDgfHtNk9ndcxNufIctUkTi2EPAXqYyyvbhuWwgxMJsavD9qwoAmNL
	8Y1+EryTOqcbfAlhr+d4pTDuM0r3Ph1qalh1Ovvnq542zfvjDUEfn5VoDfj29Z1fuH7BYpzDOZF
	8GlHx2+FNghJ34fwFr+PVz8zDnPE5XJ7nLfp+o/AJNu/LS3SGSIwEmE8Aow+tnQlRT/pDIEI7KM
	hc1UpZKW4vvk=
X-Google-Smtp-Source: AGHT+IGP/x1AQZSOiZyMN9OpYdgfMVlpTcSm49yjk/MnpwJzM7pGjLlDqyyD7CKULg4B1Eg/6rcgcQ==
X-Received: by 2002:a05:6a20:7d9e:b0:201:85f4:ade6 with SMTP id adf61e73a8af0-21fbd65e19cmr27156240637.27.1750246808841;
        Wed, 18 Jun 2025 04:40:08 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900e3a09sm10683148b3a.180.2025.06.18.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:40:08 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org,
	tytso@mit.edu,
	jack@suse.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org
Cc: muchun.song@linux.dev,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH 0/2] Postpone memcg reclaim to return-to-user path
Date: Wed, 18 Jun 2025 19:39:56 +0800
Message-Id: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

# Introduction

This patchset aims to introduce an approach to ensure that memory
allocations are forced to be accounted to the memory cgroup, even if
they exceed the cgroup's maximum limit. In such cases, the reclaim
process is postponed until the task returns to the user. This is
beneficial for users who perform over-max reclaim while holding multiple
locks or other resources (especially resources related to file system
writeback). If a task needs any of these resources, it would otherwise
have to wait until the other task completes reclaim and releases the
resources. Postponing reclaim to the return-to-user path helps avoid this issue.

# Background

We have been encountering an hungtask issue for a long time. Specifically,
when a task holds the jbd2 handler and subsequently enters direct reclaim
because it reaches the hard limit within a memory cgroup, the system may become
blocked for a long time. The stack trace of waiting thread holding the jbd2
handle is as follows (and so many other threads are waiting on the same jbd2
handle):

 #0 __schedule at ffffffff97abc6c9
 #1 preempt_schedule_common at ffffffff97abcdaa
 #2 __cond_resched at ffffffff97abcddd
 #3 shrink_active_list at ffffffff9744dca2
 #4 shrink_lruvec at ffffffff97451407
 #5 shrink_node at ffffffff974517c9
 #6 do_try_to_free_pages at ffffffff97451dae
 #7 try_to_free_mem_cgroup_pages at ffffffff974542b8
 #8 try_charge_memcg at ffffffff974f0ede
 #9 charge_memcg at ffffffff974f1d0e
#10 __mem_cgroup_charge at ffffffff974f391c
#11 __add_to_page_cache_locked at ffffffff974313e5
#12 add_to_page_cache_lru at ffffffff974324b2
#13 pagecache_get_page at ffffffff974338e3
#14 __getblk_gfp at ffffffff97556798
#15 __ext4_get_inode_loc at ffffffffc07a5518 [ext4]
#16 ext4_get_inode_loc at ffffffffc07a7fec [ext4]
#17 ext4_reserve_inode_write at ffffffffc07a9fb1 [ext4]
#18 __ext4_mark_inode_dirty at ffffffffc07aa249 [ext4]
#19 __ext4_new_inode at ffffffffc079cbae [ext4]
#20 ext4_create at ffffffffc07c3e56 [ext4]
#21 path_openat at ffffffff9751f471
#22 do_filp_open at ffffffff97521384
#23 do_sys_openat2 at ffffffff97508fd6
#24 do_sys_open at ffffffff9750a65b
#25 do_syscall_64 at ffffffff97aaed14

We've obtained a coredump and dumped struct scan_control from it by using crash tool.

struct scan_control {
  nr_to_reclaim = 32,
  order = 0 '\000',
  priority = 1 '\001',
  reclaim_idx = 4 '\004',
  gfp_mask = 17861706, __GFP_NOFAIL
  nr_scanned = 27810, 
  nr_reclaimed = 0,
  nr = {
        dirty = 27797,
        unqueued_dirty = 27797,
        congested = 0,
        writeback = 0,
        immediate = 0,
        file_taken = 27810,
        taken = 27810
  },
}

The ->nr_reclaimed is zero meaning there is no memory we have reclaimed because
most of the file pages are unqueued dirty. And ->priority is 1 also meaning we
spent so much time on memory reclamation. Since this thread has held the jbd2
handler, the jbd2 thread was waiting for the same jbd2 handler, which blocked
so many other threads from writing dirty pages as well.

0 [] __schedule at ffffffff97abc6c9
1 [] schedule at ffffffff97abcd01
2 [] jbd2_journal_wait_updates at ffffffffc05a522f [jbd2]
3 [] jbd2_journal_commit_transaction at ffffffffc05a72c6 [jbd2]
4 [] kjournald2 at ffffffffc05ad66d [jbd2]
5 [] kthread at ffffffff972bc4c0
6 [] ret_from_fork at ffffffff9720440f

Furthermore, we observed that memory usage far exceeded the configured memory maximum,
reaching around 38GB.

memory.max  : 134896020    514 GB
memory.usage: 144747169    552 GB

We investigated this issue and identified the root cause:
  try_charge_memcg:
    retry charge
     charge failed
       -> direct reclaim
        -> mem_cgroup_oom    return true，but selected task is in an uninterruptible state
           -> retry charge

In which cases, we saw many tasks in the uninterruptible (D) state with a pending
SIGKILL signal. The OOM killer selects a victim and returns success, allowing the
current thread to retry the memory charge. However, the selected task cannot acknowledge
the SIGKILL signal because it is stuck in an uninterruptible state. As a result,
the charging task resets nr_retries and attempts to reclaim again, but the victim
task never exits. This causes the current thread to enter a prolonged retry loop
during direct reclaim, holding the jbd2 handler for much more time and leading to
system-wide blocking. Why are there so many uninterruptible (D) state tasks?
Check the most common stack trace.

crash> task_struct.__state ffff8c53a15b3080
  __state = 2,   #define TASK_UNINTERRUPTIBLE        0x0002
 0 [] __schedule at ffffffff97abc6c9
 1 [] schedule at ffffffff97abcd01
 2 [] schedule_preempt_disabled at ffffffff97abdf1a
 3 [] rwsem_down_read_slowpath at ffffffff97ac05bf
 4 [] down_read at ffffffff97ac06b1
 5 [] do_user_addr_fault at ffffffff9727f1e7
 6 [] exc_page_fault at ffffffff97ab286e
 7 [] asm_exc_page_fault at ffffffff97c00d42

Check the owner of mm_struct.mmap_lock. The task below was entering memory reclaim
holding mmap lock and there are 68 tasks in this memory cgroup, with 23 of them in
the memory reclaim context.

 7 [] shrink_active_list at ffffffff9744dd46
 8 [] shrink_lruvec at ffffffff97451407
 9 [] shrink_node at ffffffff974517c9
10 [] do_try_to_free_pages at ffffffff97451dae
11 [] try_to_free_mem_cgroup_pages at ffffffff974542b8
12 [] try_charge_memcg at ffffffff974f0ede
13 [] obj_cgroup_charge_pages at ffffffff974f1dae
14 [] obj_cgroup_charge at ffffffff974f2fc2
15 [] kmem_cache_alloc at ffffffff974d054c
16 [] vm_area_dup at ffffffff972923f1
17 [] __split_vma at ffffffff97486c16
18 [] __do_munmap at ffffffff97486e78
19 [] __vm_munmap at ffffffff97487307
20 [] __x64_sys_munmap at ffffffff974873e7
21 [] do_syscall_64 at ffffffff97aaed14

Many threads was entering the memory reclaim in UN state, other threads was blocking
on mmap_lock. Although the OOM killer selects a victim, it cannot terminate it. The
task holding the jbd2 handle retries memory charge, but it fails. Reclaiming continues
while holding the jbd2 handler. write_pages also fails while waiting for the same jbd2
handler, causing repeated shrink failures and potentially leading to a system-wide block.

ps | grep UN | wc -l
1463

While the system has 1463 UN state tasks, so the way to break this akin to "deadlock" is
to let the thread holding jbd2 handler quickly exit the memory reclamation process.

We found that a related issue was reported and partially fixed in previous patches [1][2].
However, those fixes only skip direct reclamation and return a failure for some cases such
as readahead requests. As sb_getblk() is called multiple times in __ext4_get_inode_loc()
with the NOFAIL flag, the problem still exists. And it is not feasible to simply remove
__GFP_RECLAIMABLE when holding jbd2 handle to avoid potential very long memory reclaim
latency,  as __GFP_NOFAIL is not supported without __GFP_DIRECT_RECLAIM.

# Fundamentals

This patchset introduces a new task flag of PF_MEMALLOC_ACFORCE to indicate that memory
allocations are forced to be accounted to the memory cgroup, even if they exceed the cgroup's
maximum limit. The reclaim process is deferred until the task returns to the user without
holding any kernel resources for memory reclamation, thereby preventing priority inversion
problems. Any users who might encounter potential similar issues can utilize this new flag
to allocate memory and prevent long-term latency for the entire system.

# References

[1] https://lore.kernel.org/linux-fsdevel/20230811071519.1094-1-teawaterz@linux.alibaba.com/
[2] https://lore.kernel.org/all/20230914150011.843330-1-willy@infradead.org/T/#u

Zhongkun He (2):
  mm: memcg: introduce PF_MEMALLOC_ACCOUNTFORCE to postpone reclaim to
    return-to-userland path
  jbd2: mark the transaction context with the scope PF_MEMALLOC_ACFORCE
    context

 fs/jbd2/transaction.c            | 15 +++++--
 include/linux/memcontrol.h       |  6 +++
 include/linux/resume_user_mode.h |  1 +
 include/linux/sched.h            | 11 ++++-
 include/linux/sched/mm.h         | 35 ++++++++++++++++
 mm/memcontrol.c                  | 71 ++++++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 6 deletions(-)

-- 
2.39.5


